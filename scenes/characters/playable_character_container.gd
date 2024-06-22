extends CharacterBody2D # PCC (PLAYABLE CHARACTER CONTAINER)

# connect scene nodes
@export var layer: int = 4
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _interaction_manager = $InteractionManager

# track contained PC
@export var key:String

# render PCC into scene
func _ready():
	set_new_layer(layer)
	var player_type = Global.get_animation_name(Global.pcc1_player_type)
	set_key(player_type)


# swap characters with the player
func set_key(new_key: String):
	key = new_key
	Global.pcc1_player_type = Global.get_player_type(key)
	_animated_sprite.set_animation(key)

func remove_current_layer():
	_interaction_manager.remove_current_layer()
	set_collision_layer_value(self.layer, false)
	set_collision_mask_value(self.layer, false)

func set_new_layer(new_layer: int):
	z_index = -1 * new_layer
	
	remove_current_layer()
	_interaction_manager.set_new_layer(new_layer + 10)
	set_collision_layer_value(new_layer, true)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer
