extends CharacterBody2D # PCC (PLAYABLE CHARACTER CONTAINER)

# connect scene nodes
@export var layer: int = 4
@export var new_scale: float = 1
@onready var _interaction_manager = $InteractionManager

# track contained PC
@export var key: String
@export var active_sprite: AnimatedSprite2D
@export var pcc_number: Global.PCCNumber = Global.PCCNumber.PCC_1
@export var flipped: bool = false

# render PCC into scene
func _ready():
	set_new_layer(layer)
	self.scale = Vector2(new_scale, new_scale)
	
	var player_type = Global.get_animation_name(get_player_type())
	active_sprite = get_node(player_type)
	set_key(player_type)
	play_first_dialogue()


# swap characters with the player
func set_key(new_key: String):
	# save the new key locally and in Global
	key = new_key
	set_player_type(Global.get_player_type(key))
	
	# stop and hide the old sprite
	active_sprite.stop()
	active_sprite.visible = false
	
	# enable and play the new sprite
	active_sprite = get_node(key)
	active_sprite.visible = true
	active_sprite.set_animation("IDLE")
	active_sprite.play()
	
	# flip if needed
	if flipped:
		active_sprite.flip_h = true

func get_player_type():
	if pcc_number == Global.PCCNumber.PCC_1:
		return Global.pcc1_player_type
	else:
		return Global.pcc2_player_type

func set_player_type(new_player_type: Global.PlayerType):
	if pcc_number == Global.PCCNumber.PCC_1:
		Global.pcc1_player_type = new_player_type
	else:
		Global.pcc2_player_type = new_player_type

func play_first_dialogue():
	if get_player_type() == Global.PlayerType.THIEF and Global.first_thief:
		if Dialogic.current_timeline != null:
			await Dialogic.timeline_ended
		Dialogic.start("Thief-Intro")
		Global.first_thief = false
	elif get_player_type() == Global.PlayerType.MESSENGER and Global.first_messenger:
		if Dialogic.current_timeline != null:
			await Dialogic.timeline_ended
		Dialogic.start("Messenger-Intro")
		Global.first_messenger = false

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
