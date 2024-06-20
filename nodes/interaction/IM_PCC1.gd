extends InteractionManager # PLAYER CONTAINER 1

# overwrite with interaction behavior for each interactable object
func interact() -> void:
	var key = get_parent().key
	if key == "NULL":
		print("PCC: null key")
	else:
		print("PCC: let's swap characters")
		var newKey = interaction_partner.get_parent().key
		interaction_partner.interact_echo(key)
		get_parent().set_key(newKey)
