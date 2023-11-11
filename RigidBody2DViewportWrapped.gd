extends RigidBody2D

class_name RigidBody2DViewportWrapped

@onready var viewport_size = get_viewport().size

func _integrate_forces(state):
	keep_in_viewport(state)

func keep_in_viewport(state):
	if state.transform.origin.x + get_sprite_size().x / 2 < 0:
		state.transform.origin.x = viewport_size.x + get_sprite_size().x / 2
	if state.transform.origin.x - get_sprite_size().x / 2 > viewport_size.x:
		state.transform.origin.x = -get_sprite_size().x / 2
		
	if state.transform.origin.y + get_sprite_size().y / 2 < 0:
		state.transform.origin.y = viewport_size.y + get_sprite_size().y / 2
	if state.transform.origin.y - get_sprite_size().y / 2 > viewport_size.y:
		state.transform.origin.y = -get_sprite_size().y / 2

func get_sprite_size():
	push_error('You must implement get_sprite_size() function')
