extends AnimatedSprite2D # Action Cues pop up in interaction range

# connect scene nodes
@onready var _interaction_manager = get_parent().get_node("InteractionManager")


# prepare to catch the interaction manager signals
func _ready():
	print("READY!")
	_interaction_manager.enter_interaction.connect(on_enter_interaction)
	_interaction_manager.exit_interaction.connect(on_exit_interaction)


# show action cues when player enters interaction partner range
func on_enter_interaction():
	set_animation("INTERACT")


# hide action cues when player enters interaction partner range
func on_exit_interaction():
	set_animation("NULL")
