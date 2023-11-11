extends RigidBody2DViewportWrapped

class_name Player

signal has_died

var rotation_speed = TAU
var thrust_force = 400

var fire_cooldown = 0.05
var fire_cooldown_remaining = 0
const BULLET_SCENE = preload("res://laser.tscn")

var is_invincible : bool = true

@onready var sprite_size = $Sprite2D.get_rect().size

# Called every physic frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	angular_velocity = 0
	
	if is_invincible:
		enable_invincibility_animation()
	
	if Input.is_action_pressed("rotate_ccw"):
		angular_velocity = rotation_speed
	
	if Input.is_action_pressed("rotate_cw"):
		angular_velocity = -rotation_speed
	
	if Input.is_action_pressed("go_forward"):
		apply_force(Vector2.UP.rotated(rotation) * thrust_force)
	
	fire_cooldown_remaining -= delta
	if fire_cooldown_remaining <= 0 && Input.is_action_pressed("fire"):
		fire_cooldown_remaining = fire_cooldown
		shoot()
	
func shoot():
	if is_invincible:
		return
		
	var laser = BULLET_SCENE.instantiate()
	laser.rotation = self.rotation
	laser.position = $LaserSpawnPoint.global_position
	get_parent().add_child(laser)
	
func get_sprite_size():
	return sprite_size

func _on_body_entered(body):
	if is_invincible:
		return
		
	has_died.emit()

func enable_invincibility_animation():
	$Sprite2D.modulate.a = sin($InvincibilityTimer.time_left * 50.0) / 4.0 + 0.50
	
func disable_invincibility_animation():
	$Sprite2D.modulate.a = 1.0

func _on_invincibility_timer_timeout():
	is_invincible = false
	disable_invincibility_animation()
