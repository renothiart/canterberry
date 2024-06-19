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

var playerType: PlayerType = PlayerType.STRAWBERRY
enum PlayerType {
	STRAWBERRY,
	TOMATO,
	RASPBERRY,
}
