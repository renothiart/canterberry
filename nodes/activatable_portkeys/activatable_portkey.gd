extends Area2D

@export var portkey_location: Global.PortkeyLocation
@export var paired_portkey_location: Global.PortkeyLocation
@export_multiline var linked_level_name: String
@export var action: String = "move_up"
@export var new_scale: float = 1.0
@export var layer: int = 2

func _ready():
	set_layer(layer)

# Sets the layer for both rendering and collision
func set_layer(new_layer: int):
	z_index = -1 * new_layer
	
	set_collision_mask_value(self.layer, false)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer

func _input(event):
	if event.is_action_pressed(action) and has_overlapping_bodies():
		Global.current_portkey_location = paired_portkey_location
		call_deferred("change_level")

func change_level():
	get_tree().change_scene_to_file(linked_level_name)

# dummy function, buffering not needed due to activation
func start_teleport_buffer():
	pass

func is_forward_movement():
	if action == "move_up":
		return true
	else:
		return false

func _on_body_entered(body):
	if body.has_method("enable_arrow"):
		body.enable_arrow(is_forward_movement())

func _on_body_exited(body):
	if body.has_method("disable_arrow"):
		body.disable_arrow(is_forward_movement())
