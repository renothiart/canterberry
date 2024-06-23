extends Node

var portkey_map

@export var fg_left_portkey: Area2D
@export var fg_right_portkey: Area2D
@export var mg_left_portkey: Area2D
@export var mg_right_portkey: Area2D
@export var bg_left_portkey: Area2D
@export var bg_right_portkey: Area2D

# credits scene filepath
var credits_filepath = "res://credits.tscn"

# required variables enabling teleporting
var teleport_buffer_time: float = 0.05
var teleport_buffer_time_remaining: float = 0

func _init():
	if Global.is_princess_in_castle and \
			(Dialogic.VAR.Knight.MetPrincess or Dialogic.VAR.Messenger.MetPrincess):
		Global.is_princess_in_castle = false
	if Global.is_messenger_in_port and \
			(Dialogic.VAR.Knight.MetMessenger or Dialogic.VAR.Thief.MetMessenger):
		Global.is_messenger_in_port = false
	
	if Global.pcc1_player_type == Global.PlayerType.NULL:
		if not Global.is_princess_in_castle:
			Global.pcc1_player_type = Global.PlayerType.THIEF
		elif not Global.is_messenger_in_port:
			Global.pcc1_player_type = Global.PlayerType.MESSENGER
	elif Global.pcc2_player_type == Global.PlayerType.NULL \
			and not Global.is_princess_in_castle \
			and not Global.is_messenger_in_port:
		if Global.pcc1_player_type == Global.PlayerType.THIEF \
				or Global.current_player_type == Global.PlayerType.THIEF:
			Global.pcc2_player_type = Global.PlayerType.MESSENGER
		elif Global.pcc1_player_type == Global.PlayerType.MESSENGER \
				or Global.current_player_type == Global.PlayerType.MESSENGER:
			Global.pcc2_player_type = Global.PlayerType.THIEF

func _ready():
	if Global.first_load:
		$AnimationPlayer.queue("fade_in")
		Global.first_load = false
	else:
		$ColorRect.visible = false

	Dialogic.signal_event.connect(process_dialogic_signal)
	
	portkey_map = {
		Global.PortkeyLocation.FG_LEFT: fg_left_portkey,
		Global.PortkeyLocation.FG_RIGHT: fg_right_portkey,
		Global.PortkeyLocation.MG_LEFT: mg_left_portkey,
		Global.PortkeyLocation.MG_RIGHT: mg_right_portkey,
		Global.PortkeyLocation.BG_LEFT: bg_left_portkey,
		Global.PortkeyLocation.BG_RIGHT: bg_right_portkey,
	}
	load_portkey()

# To circumvent this, we insert a small delay without physics processing.
# see: https://forum.godotengine.org/t/what-is-the-proper-way-to-teleport-rigidbody2d/27752/2
func _process(delta):
	teleport_buffer_time_remaining -= delta
	if (teleport_buffer_time_remaining <= 0):
		set_process(false)
		set_physics_process(true)

# Starts a disabled physics buffer to allow teleporting
func start_teleport_buffer():
	set_process(true)
	set_physics_process(false)
	teleport_buffer_time_remaining = teleport_buffer_time

func is_teleporter(child):
	return child != null \
		and child.has_method("teleport_player") \
		and child.has_method("start_teleport_buffer")

func enable_portkeys():
	var all_portkeys = portkey_map.values().filter(func(n): return n != null)
	for portkey in all_portkeys:
		if portkey.has_method("has_overlapping_player") \
				and portkey.has_overlapping_player():
			portkey.enable()
			portkey._on_body_entered(%Player)

func load_portkey():
	if Global.current_portkey_location != Global.PortkeyLocation.UNDEFINED:
		var portkey = portkey_map[Global.current_portkey_location]
		
		var all_portkeys = portkey_map.values().filter(func(n): return n != null)
		for port in all_portkeys:
			port.start_teleport_buffer()
		
		for teleporter in get_children().filter(is_teleporter):
			teleporter.start_teleport_buffer()
		
		get_tree().paused = true
		
		%Player.set_new_layer(portkey.layer)
		%Player.global_position = portkey.global_position
		%Player.global_scale = Vector2(portkey.new_scale, portkey.new_scale)
		
		get_tree().paused = false

func process_dialogic_signal(argument: String):
	if argument == "found_treasure":
		$FGActivatablePortkey.set_layer(2)
		$Player.start_teleport_buffer($Player.layer)
		$PlayerInventory.refresh_inventory()
	elif argument == "collect_flyer":
		Global.messenger_has_flyer = true
		$PlayerInventory.refresh_inventory()
	elif argument == "end_show":
		await Dialogic.timeline_ended
		$AnimationPlayer.queue("fade_out")
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file(credits_filepath)
