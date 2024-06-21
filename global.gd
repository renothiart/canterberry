extends Node

var current_portkey_location: PortkeyLocation = PortkeyLocation.UNDEFINED
enum PortkeyLocation {
	UNDEFINED,
	
	# these should be removed, but it breaks - likely a godot bug
	HUB_LEFT,
	HUB_RIGHT,
	FOREST_1_FG_LEFT,
	FOREST_1_BG_RIGHT,
	
	# these should be used
	FG_LEFT,
	FG_RIGHT,
	MG_LEFT,
	MG_RIGHT,
	BG_LEFT,
	BG_RIGHT,
}

var current_player_type: PlayerType = PlayerType.KNIGHT
enum PlayerType {
	NULL,
	KNIGHT,
	THIEF,
	MESSENGER,
}

var player_type_to_animation = {
	PlayerType.NULL: "NULL",
	PlayerType.KNIGHT: "SK",
	PlayerType.THIEF: "TT",
	PlayerType.MESSENGER: "RM",
}

func get_animation_name(player_type: PlayerType):
	return player_type_to_animation[player_type]
