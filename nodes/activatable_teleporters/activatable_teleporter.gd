extends Area2D

@export var pairedTeleporter: Area2D
@export var action: String = "move_up"
@export var newScale: float = 1.0
@export var layer: int = 2

func _ready():
	set_layer(layer)

func teleport_player():
	%Player.start_teleport_buffer(layer)
	
	%Player.remove_current_layer()
	%Player.global_position.y = global_position.y
	%Player.global_scale = Vector2(newScale, newScale)

# Sets the layer for both rendering and collision
func set_layer(new_layer: int):
	z_index = -1 * new_layer
	
	set_collision_mask_value(self.layer, false)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer

func _input(event):
	if event.is_action_pressed(action) and has_overlapping_bodies():
		pairedTeleporter.teleport_player()

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
