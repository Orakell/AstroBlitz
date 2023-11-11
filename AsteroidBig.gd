extends RigidBody2DViewportWrapped

signal has_been_shot

const STARTING_FORCE = 300

@onready var sprite_size = $Sprite2D.get_rect().size

@export var debris_scene : PackedScene
@export var debris_number = randi_range(2, 4)

func _ready():
	apply_impulse(Utils.random_unit_vector2() * randf_range(STARTING_FORCE / 2.0, STARTING_FORCE * 2.0))

func get_sprite_size():
	return sprite_size

func _on_has_been_shot():
	if debris_scene:
		for i in debris_number:
			var debris = debris_scene.instantiate()
			debris.position = self.global_position
			call_deferred("spawn_asteroid", debris)
	
	queue_free()
	
	Messenger.ASTEROID_DESTROYED.emit(self)

func spawn_asteroid(debris):
	get_parent().add_child(debris)
