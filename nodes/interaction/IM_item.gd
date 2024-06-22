extends InteractionManager # ITEM


# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	var player_type = Global.current_player_type
	var item_type = get_parent().item_type
	if player_type == Global.PlayerType.NULL \
			or item_type == Global.ItemType.NULL:
		print("Error: null player or character")
		return
	
	# interaction type: dialogue
	if input == "interact":
		if Dialogic.current_timeline == null:
			var player_name = Global.get_dialogue_name_from_player(player_type)
			var item_name = Global.get_dialogue_name_from_npc(item_type)
			Dialogic.start(player_name + "-" + item_name)
	
	# interaction type: undefined
	else:
		print("Undefined Input: " + input)
