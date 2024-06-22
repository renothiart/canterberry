extends CharacterBody2D

# required variables enabling teleporting
var teleport_buffer_time: float = 0.02
var teleport_buffer_time_remaining: float = 0
var buffered_layer = 0

# connect scene nodes
@export var layer: int = 4
@onready var _interaction_manager = $InteractionManager

# stupid variables for a very lazy, hacky solution
@onready var _SK = $SK
@onready var _TT = $TT
@onready var _RM = $RM

# key for current PC sprite, start as strawberry knight
@export var key: String
@export var active_sprite: AnimatedSprite2D


# render player into scene
func _ready():
	set_new_layer(layer)
	set_process(false)
	
	var player_type = Global.get_animation_name(Global.current_player_type)
	active_sprite = get_node(player_type)
	set_key(player_type)


# define all input behaviors
func _unhandled_input(_event_) -> void:
	if Input.is_action_just_pressed("interact"):
		_interaction_manager.attempt_interaction("interact")
	
	if Input.is_action_just_pressed("swap_characters"):
		_interaction_manager.attempt_interaction("swap_characters")


# define echo interaction behaviors
# expects key to be a string, initials of target PC (SK, TT, RM)
func set_key(new_key: String) -> void:
	# save the new key locally and in Global
	key = new_key
	Global.current_player_type = Global.get_player_type(key)
	
	# stop and disable the old sprite
	active_sprite.stop()
	active_sprite.visible = false
	
	# enable the new sprite
	active_sprite = get_node(key)
	active_sprite.visible = true


# basic physics movement, x-axis only
func _physics_process(_delta):
	var _input_axis = Input.get_axis("move_left", "move_right")
	var direction = Vector2(_input_axis, 0.0)
	velocity = direction * 600.0
	
	if _input_axis == 0.0:
		active_sprite.set_animation("IDLE")
	
	else: # the very lazy, hacky solution I meantioned earlier
		active_sprite.set_animation("WALK")
		
		if _input_axis > 0.0:
			_SK.flip_h = true
			_TT.flip_h = true
			_RM.flip_h = true
		
		if _input_axis < 0.0:
			_SK.flip_h = false
			_TT.flip_h = false
			_RM.flip_h = false
	
	move_and_slide()
	active_sprite.play()


# Teleporting doesn't mesh well with the physics engine.
# To circumvent this, we insert a small delay without physics processing.
# see: https://forum.godotengine.org/t/what-is-the-proper-way-to-teleport-rigidbody2d/27752/2
func _process(delta):
	teleport_buffer_time_remaining -= delta
	if (teleport_buffer_time_remaining <= 0):
		set_process(false)
		set_physics_process(true)
		set_new_layer(buffered_layer)
		buffered_layer = 0


# Starts a disabled physics buffer to allow teleporting
func start_teleport_buffer(new_layer):
	set_process(true)
	set_physics_process(false)
	teleport_buffer_time_remaining = teleport_buffer_time
	buffered_layer = new_layer


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
