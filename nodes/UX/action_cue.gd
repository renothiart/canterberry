extends AnimatedSprite2D # Action Cues pop up in interaction range

# connect scene nodes
@onready var _interaction_manager = get_parent().get_node("InteractionManager")
var _is_pcc = false

# prepare to catch the interaction manager signals
func _ready():
	_interaction_manager.enter_interaction.connect(on_enter_interaction)
	_interaction_manager.exit_interaction.connect(on_exit_interaction)
	_is_pcc = _interaction_manager.is_pcc


# show action cues when player enters interaction partner range
func on_enter_interaction():
	if _is_pcc:
		set_animation("BOTH")
	else:
		set_animation("INTERACT")


# hide action cues when player enters interaction partner range
func on_exit_interaction():
	set_animation("NULL")
