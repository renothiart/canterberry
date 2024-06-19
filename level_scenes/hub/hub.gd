extends Node

var portkey_map

# required variables enabling teleporting
var teleport_buffer_time: float = 0.05
var teleport_buffer_time_remaining: float = 0

func _ready():
	portkey_map = {
		Global.PortkeyLocation.HUB_LEFT: %LeftPortkey,
		Global.PortkeyLocation.HUB_RIGHT: %RightPortkey
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

func load_portkey():
	if Global.current_portkey_location != Global.PortkeyLocation.UNDEFINED:
		var portkey = portkey_map[Global.current_portkey_location]
		%LeftPortkey.start_teleport_buffer()
		%RightPortkey.start_teleport_buffer()
		#%LeftPortkey.disable()
		#%RightPortkey.disable()
		#start_teleport_buffer()
		#%StrawberryKnight.start_teleport_buffer(portkey.layer)
	#
		get_tree().paused = true
		#%StrawberryKnight.remove_current_layer()
		%StrawberryKnight.set_new_layer(portkey.layer)
		%StrawberryKnight.global_position = portkey.global_position
		%StrawberryKnight.global_scale = Vector2(portkey.new_scale, portkey.new_scale)
		
		get_tree().paused = false
