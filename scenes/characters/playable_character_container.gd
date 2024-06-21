extends CharacterBody2D # PCC (PLAYABLE CHARACTER CONTAINER)

# connect scene nodes
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _interaction_manager = $InteractionManager

# track contained PC
@export var key:String


# render PCC into scene
func _ready():
	var player_type = Global.get_animation_name(Global.pcc1_player_type)
	set_key(player_type)


# swap characters with the player
func set_key(new_key: String):
	key = new_key
	Global.pcc1_player_type = Global.get_player_type(key)
	_animated_sprite.set_animation(key)
