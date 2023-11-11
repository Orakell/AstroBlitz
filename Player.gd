extends RigidBody2DViewportWrapped

class_name Player

signal has_died

var rotation_speed = TAU
var thrust_force = 400

@onready var sprite_size = $Sprite2D.get_rect().size

# Called every physic frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	angular_velocity = 0
	
	if Input.is_action_pressed("rotate_ccw"):
		angular_velocity = rotation_speed
	
	if Input.is_action_pressed("rotate_cw"):
		angular_velocity = -rotation_speed
	
	if Input.is_action_pressed("go_forward"):
		apply_force(Vector2.UP.rotated(rotation) * thrust_force)
	
	if Input.is_action_pressed("fire"):
		pass
	
func get_sprite_size():
	return sprite_size

func _on_body_entered(body):
	has_died.emit()
