extends RigidBody2D

# connect scene nodes
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _interaction_manager = $InteractionManager

# render player container into scene
