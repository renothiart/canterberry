extends Node

var portkey_map

@export var fg_left_portkey: Area2D
@export var fg_right_portkey: Area2D
@export var mg_left_portkey: Area2D
@export var mg_right_portkey: Area2D
@export var bg_left_portkey: Area2D
@export var bg_right_portkey: Area2D

# required variables enabling teleporting
var teleport_buffer_time: float = 0.05
var teleport_buffer_time_remaining: float = 0

func _ready():
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
		if portkey.has_overlapping_player():
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
