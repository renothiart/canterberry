extends Node

# required for treasure room entry bug
var player_facing_right = true

# player inventory
var knight_inventory = []
var thief_has_treasure = false
var messenger_has_flyer = false

# PCC Number
enum PCCNumber {
	PCC_1,
	PCC_2,
}

# move player characters
var is_princess_in_castle = true
var is_messenger_in_port = true

# Portkey locations
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

# player type functionality
var current_player_type: PlayerType = PlayerType.KNIGHT
var pcc1_player_type: PlayerType = PlayerType.THIEF
var pcc2_player_type: PlayerType = PlayerType.MESSENGER
enum PlayerType {
	NULL,
	KNIGHT,
	THIEF,
	MESSENGER,
}

# NPC functionality
enum CharacterType {
	NULL,
	KNIGHT,
	THIEF,
	MESSENGER,
	BARD,
	BABY,
	WITCH,
	BANDIT,
	PRINCESS,
	MONK,
	JESTER,
	SQUIRE,
	KING,
	TOWNSFOLK,
	BAKER,
	MAID,
}

# item functionality
enum ItemType {
	NULL,
	POTION,
	MUSHROOM,
	BREAD,
	EGG,
	TOY,
	TREASURE,
	FLYER,
}


# player animation names
var player_type_to_animation = {
	PlayerType.NULL: "NULL",
	PlayerType.KNIGHT: "SK",
	PlayerType.THIEF: "TT",
	PlayerType.MESSENGER: "RM",
}

# player animation names reverse
var animation_to_player_type = {
	"NULL": PlayerType.NULL,
	"SK": PlayerType.KNIGHT,
	"TT": PlayerType.THIEF,
	"RM": PlayerType.MESSENGER,
}

func get_animation_name(player_type: PlayerType):
	return player_type_to_animation[player_type]

func get_player_type(animation: String):
	return animation_to_player_type[animation]


# player dialogue names
var player_type_to_dialogue_name = {
	PlayerType.NULL: "Null",
	PlayerType.KNIGHT: "Knight",
	PlayerType.THIEF: "Thief",
	PlayerType.MESSENGER: "Messenger",
}

# NPC dialogue names
var character_type_to_dialogue_name = {
	CharacterType.NULL: "Null",
	CharacterType.KNIGHT: "Knight",
	CharacterType.THIEF: "Thief",
	CharacterType.MESSENGER: "Messenger",
	CharacterType.BARD: "Bard",
	CharacterType.BABY: "Baby",
	CharacterType.WITCH: "Witch",
	CharacterType.BANDIT: "Bandit",
	CharacterType.PRINCESS: "Princess",
	CharacterType.MONK: "Monk",
	CharacterType.JESTER: "Jester",
	CharacterType.SQUIRE: "Squire",
	CharacterType.KING: "King",
	CharacterType.TOWNSFOLK: "Townsfolk",
	CharacterType.BAKER: "Baker",
	CharacterType.MAID: "Maid",
}

# item dialogue names
var item_type_to_dialogue_name = {
	ItemType.NULL: "Null",
	ItemType.POTION: "Potion",
	ItemType.MUSHROOM: "Mushroom",
	ItemType.BREAD: "Bread",
	ItemType.EGG: "Egg",
	ItemType.TOY: "Toy",
	ItemType.TREASURE: "Treasure",
	ItemType.FLYER: "Flyer",
}

func get_dialogue_name_from_player(player_type: PlayerType):
	return player_type_to_dialogue_name[player_type]

func get_dialogue_name_from_npc(character_type: CharacterType):
	return character_type_to_dialogue_name[character_type]

func get_dialogue_name_from_item(item_type: ItemType):
	return item_type_to_dialogue_name[item_type]
