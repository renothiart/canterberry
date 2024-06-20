extends InteractionManager # BANANA JESTER

# overwrite with interaction behavior for each interactable object
func interact() -> void:
	#print("I am the banana jester, admire my whimsical peel")
	print("Now you are the Raspberry Messenger")
	interaction_partner.interact_echo("RM")
