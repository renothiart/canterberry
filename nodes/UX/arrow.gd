extends AnimatedSprite2D # Forward arrow to indicate movement

@export var is_forward: bool = true

# shows the forward arrow
func enable_forward_arrow():
	set_animation("FORWARD")

# shows the backward arrow
func enable_backward_arrow():
	set_animation("BACKWARD")

# hides the arrow
func disable_arrow():
	set_animation("NULL")
