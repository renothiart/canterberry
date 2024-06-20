extends InteractionManager # PEAR MONK

# overwrite with interaction behavior for each interactable object
func interact() -> void:
	#print("I am the pear monk, praise be to the golden holiday pear")
	print("Now you will be the Tomato Thief")
	interaction_partner.interact_echo("TT")
