extends Node

class_name Main

signal score_changed
signal level_changed
signal lives_changed

signal GAME_OVER

var player_scene = preload("res://player.tscn")
var asteroid_scene = preload("res://asteroid_big.tscn")
@export var asteroid_container : Node2D

var asteroid_spawn_number = 0
var asteroid_spawn_range_min = 200
var asteroid_spawn_range_max = 400

var player_node : Node2D

var score:
	get:
		return score
	set(value):
		score = value
		score_changed.emit(score)
		
var lives:
	get:
		return lives
	set(value):
		lives = value
		lives_changed.emit(lives)
		
var level:
	get:
		return level
	set(value):
		level = value
		level_changed.emit(level)

@onready var viewport_size = get_viewport().size

func _ready():
	Messenger.connect("ASTEROID_DESTROYED", _on_asteroid_shot)
	setup_new_game()
	
func _on_asteroid_shot(asteroid):
	if asteroid.debris_scene:
		score += 5
	else:
		score += 2
		
		if asteroid_container.get_child_count() == 1:
			setup_new_level()
	
func setup_new_game():
	cleanup_game()
	lives = 3
	score = 0
	level = 0
	asteroid_spawn_number = 0
	setup_new_level()

func setup_new_level():
	level += 1
	spawn_player()
	asteroid_spawn_number += randf_range(1, 2)
	
	for i in asteroid_spawn_number:
		spawn_asteroid()

func cleanup_game():
	if player_node:
		player_node.queue_free()
		player_node = null
	
	for asteroid in asteroid_container.get_children():
		asteroid.queue_free()
	
	
func spawn_player():
	if player_node:
		player_node.queue_free()
		player_node = null
	
	player_node = player_scene.instantiate()
	player_node.position = viewport_size / 2.0
	player_node.has_died.connect(_on_player_death)
	call_deferred("spawn_player_deferred", player_node)

func spawn_player_deferred(node):
	add_child(node)
	
func spawn_asteroid():
	var asteroid = asteroid_scene.instantiate()
	asteroid.position = viewport_size / 2.0 + (Utils.random_unit_vector2() * randf_range(asteroid_spawn_range_min, asteroid_spawn_range_max))
	asteroid_container.add_child(asteroid)

func _on_player_death():
	if lives <= 0:
		game_over()
		return
		
	lives -= 1
	spawn_player()

func add_to_score(number):
	score += number

func game_over():
	if player_node:
		player_node.queue_free()
		player_node = null
		
	GAME_OVER.emit()
