extends Node

var player_scene = preload("res://player.tscn")
var asteroid_scene = preload("res://asteroid_big.tscn")

var asteroid_spawn_range_min = 100
var asteroid_spawn_range_max = 300

var player_node

@onready var viewport_size = get_viewport().size

func _ready():
	setup_new_level(3)

func setup_new_level(asteroid_number):
	spawn_player()
	
	for i in asteroid_number:
		spawn_asteroid()
	
func spawn_player():
	if player_node:
		player_node.queue_free()
	
	player_node = player_scene.instantiate()
	player_node.position = viewport_size / 2.0
	player_node.has_died.connect(_on_player_death)
	add_child(player_node)
	
func spawn_asteroid():
	var asteroid = asteroid_scene.instantiate()
	asteroid.position = viewport_size / 2.0 + (Utils.random_unit_vector2() * randf_range(asteroid_spawn_range_min, asteroid_spawn_range_max))
	add_child(asteroid)

func _on_player_death():
	spawn_player()

