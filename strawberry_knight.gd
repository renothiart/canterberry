extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var _input_axis = Input.get_axis("move_left", "move_right")
	var direction = Vector2(_input_axis, 0.0)
	velocity = direction * 600.0
	
	if _input_axis < 0.0:
		_animated_sprite.set_frame(0)
	else:
		_animated_sprite.set_frame(1)
	
	move_and_slide()
