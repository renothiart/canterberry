extends InteractionManager # NPC

# so the action cue knows it lives in a PCC
func _ready():
	is_pcc = false

# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	
	var player_type = Global.current_player_type
	var character_type = get_parent().character_type
	if player_type == Global.PlayerType.NULL \
			or character_type == Global.CharacterType.NULL:
		print("Error: null player or character")
		return
	
	# interaction type: dialogue
	if input == "interact":
		if Dialogic.current_timeline == null:
			var player_name = Global.get_dialogue_name_from_player(player_type)
			var npc_name = Global.get_dialogue_name_from_npc(character_type)
			Dialogic.start(player_name + "-" + npc_name)
	
	# interaction type: undefined
	else:
		print("Undefined Input: " + input)
