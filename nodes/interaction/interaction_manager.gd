extends Area2D

class_name InteractionManager
var interaction_partner: InteractionManager

# call this on interaction controller input
func attempt_interaction() -> void:
	if interaction_partner != null:
		interaction_partner.interact()


# overwrite with interaction behavior for each interactable object
func interact() -> void:
	print("No behavior defined for this interaction")


# connected to InteractionManager on_enter signal
func _on_Interaction_Manager_area_entered(area):
	interaction_partner = area


# connected to InteractionManager on_exit signal
func _on_Interaction_Manager_area_exited(area):
	if interaction_partner == area:
		interaction_partner = null
