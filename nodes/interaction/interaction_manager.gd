extends Area2D


class_name InteractionManager
var interaction_partner: InteractionManager


func attempt_interaction():
	if interaction_partner != null:
		interaction_partner.interact()


func interact():
	print("interaction test")


func _on_Enter(area):
	interaction_partner = area

	
func _on_Exit(area):
	if interaction_partner == area:
		interaction_partner = null
