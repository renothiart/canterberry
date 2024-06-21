extends Area2D

@export var portkey_location: Global.PortkeyLocation
@export var paired_portkey_location: Global.PortkeyLocation
@export_multiline var linked_level_name: String
@export var new_scale: float = 1.0
@export var layer: int = 2

var disabled = false

# required variables enabling teleporting
var teleport_buffer_time: float = 0.2
var teleport_buffer_time_remaining: float = 0

func _ready():
	set_layer(layer)

# Sets the layer for both rendering and collision
func set_layer(new_layer: int):
	z_index = -1 * new_layer
	
	set_collision_mask_value(self.layer, false)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer

# Teleporting doesn't mesh well with the physics engine.
# To circumvent this, we insert a small delay without physics processing.
# see: https://forum.godotengine.org/t/what-is-the-proper-way-to-teleport-rigidbody2d/27752/2
func _process(delta):
	teleport_buffer_time_remaining -= delta
	if (teleport_buffer_time_remaining <= 0):
		set_process(false)
		set_physics_process(true)
		if not has_overlapping_bodies():
			enable()

# Starts a disabled physics buffer to allow teleporting
func start_teleport_buffer():
	disable()
	set_process(true)
	set_physics_process(false)
	teleport_buffer_time_remaining = teleport_buffer_time

func has_overlapping_player():
	return get_overlapping_bodies().filter(func(n): return n.has_method("start_teleport_buffer"))

func _on_body_entered(_body):
	if not disabled:
		Global.current_portkey_location = paired_portkey_location
		call_deferred("change_level")

func _on_body_exited(_body):
	enable()

func disable():
	disabled = true

func enable():
	disabled = false

func change_level():
	get_tree().change_scene_to_file(linked_level_name)
