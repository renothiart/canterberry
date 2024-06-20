extends CharacterBody2D # PCC (PLAYABLE CHARACTER CONTAINER)

# connect scene nodes
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _interaction_manager = $InteractionManager

# track contained PC
var key = "RM"


# render PCC into scene
func _ready():
	set_key(key)


# swap characters with the player
func set_key(newKey):
	key = newKey
	_animated_sprite.set_animation(key)
