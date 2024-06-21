extends InteractionManager # PLAYER CONTAINER 1

# so the action cue knows it lives in a PCC
func _ready():
	is_pcc = true

# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	# interaction type: dialogue
	if input == "e":
		print("We're talking")
	
	# interaction type: player character swap
	else: if input == "q":
		print("We're swapping")
		
		var key = get_parent().key
		
		# PCC is null, cannot swap
		if key == "NULL":
			print("PCC: null key. Cannot swap.")
		
		# PCC is not null, swap characters
		else:
			print("PCC: let's swap characters")
			var new_key = interaction_partner.get_parent().key
			interaction_partner.interact_echo(key)
			get_parent().set_key(new_key)
	
	# interaction type: undefined
	else:
		print("Undefinted Input:")
		print(input)
