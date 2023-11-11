extends RigidBody2DViewportWrapped

const STARTING_FORCE = 300

@onready var sprite_size = $Sprite2D.get_rect().size

func _ready():
	apply_impulse(Utils.random_unit_vector2() * randf_range(STARTING_FORCE / 2, STARTING_FORCE * 2))

func get_sprite_size():
	return sprite_size
