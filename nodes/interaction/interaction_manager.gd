extends Area2D

# interaction managers interact with each other
class_name InteractionManager
var interaction_partner: InteractionManager

# interaction managers signal to other nodes
signal enter_interaction
signal exit_interaction

# is this interactable object a PCC?
var is_pcc = false


# call this on interaction controller input
func attempt_interaction(input: String) -> void:
	if interaction_partner != null:
		interaction_partner.interact(input)


# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	print("No behavior defined for this interaction")


# overwrite only when applicable
func interact_echo(key: String) -> void:
	print("No echo behavior defined for this interaction")


# connected to InteractionManager on_enter signal
func _on_Interaction_Manager_area_entered(area):
	enter_interaction.emit()
	interaction_partner = area


# connected to InteractionManager on_exit signal
func _on_Interaction_Manager_area_exited(area):
	exit_interaction.emit()
	if interaction_partner == area:
		interaction_partner = null
