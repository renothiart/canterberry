extends InteractionManager # PLAYER CONTAINER 1

# so the action cue knows it lives in a PCC
func _ready():
	is_pcc = true

# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	# interaction type: dialogue
	if input == "interact":
		print("Dialogue hook missing")
	
	# interaction type: player character swap
	else: if input == "swap_characters":
		var key = get_parent().key
		
		# PCC is null, cannot swap
		if key == "NULL":
			print("PCC: null key. Cannot swap.")
		
		# PCC is not null, swap characters
		else:
			var new_key = interaction_partner.get_parent().key
			interaction_partner.interact_echo(key)
			get_parent().set_key(new_key)
	
	# interaction type: undefined
	else:
		print("Undefined Input: " + input)
