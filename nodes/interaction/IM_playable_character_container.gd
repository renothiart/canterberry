extends InteractionManager # PLAYER CONTAINER 1

# so the action cue knows it lives in a PCC
func _ready():
	is_pcc = true

# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	# interaction type: dialogue
	if input == "interact":
		var player_type = Global.current_player_type
		var pcc_type = get_parent().get_player_type()
		if player_type == Global.PlayerType.NULL \
				or pcc_type == Global.PlayerType.NULL:
			print("Error: null player or character")
			return
		elif Dialogic.current_timeline == null:
			var player_name = Global.get_dialogue_name_from_player(player_type)
			var npc_name = Global.get_dialogue_name_from_player(pcc_type)
			Dialogic.start(player_name + "-" + npc_name)
	
	# interaction type: player character swap
	elif input == "swap_characters":
		var key = get_parent().key
		
		# PCC is null, cannot swap
		if key == "NULL":
			print("PCC: null key. Cannot swap.")
		
		# PCC is not null, swap characters
		else:
			var new_key = interaction_partner.get_parent().key
			interaction_partner.interact_echo(key)
			get_parent().set_key(new_key)
			$"../../PlayerInventory".refresh_inventory()
	
	# interaction type: undefined
	else:
		print("Undefined Input: " + input)
