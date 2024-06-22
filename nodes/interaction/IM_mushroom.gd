extends InteractionManager # mushroom

var item_name = "Mushroom"

# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	var player_type = Global.current_player_type
	if player_type == Global.PlayerType.NULL:
		print("Error: player or character")
		return
	
	# interaction type: dialogue
	if input == "interact":
		if Dialogic.current_timeline == null:
			var player_name = Global.get_dialogue_name_from_player(player_type)
			Dialogic.start(player_name + "-" + item_name)
	
	# interaction type: undefined
	else:
		print("Undefined Input: " + input)
