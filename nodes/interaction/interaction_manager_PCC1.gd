extends InteractionManager # PLAYER CONTAINER 1

# overwrite with interaction behavior for each interactable object
func interact() -> void:
	#print("I am the pear monk, praise be to the golden holiday pear")
	print("I am player container 1")
	print("We are now switching characters")
	interaction_partner.interact_echo("TT")
