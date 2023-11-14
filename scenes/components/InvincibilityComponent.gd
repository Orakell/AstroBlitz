extends Node2D

class_name InvincibilityComponent

@export var on = true
@export var sprite: Sprite2D


func _ready():
	$Timer.connect("timeout", self._on_timer_timeout)
	pass

func enable():
	on = true

func enable_animation():
	sprite.modulate.a = sin($Timer.time_left * 50.0) / 4.0 + 0.50
	
func disable():
	on = false
	
func disable_animation():
	sprite.modulate.a = 1.0

func is_invincible():
	return on

func _physics_process(_delta):
	if self.is_invincible():
		self.enable_animation()

func _on_timer_timeout():
	disable()
	disable_animation()
