extends RigidBody2DViewportWrapped

@onready var sprite_size = $Sprite2D.get_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_sprite_size():
	return sprite_size
