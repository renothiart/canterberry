extends Area2D

@export var pairedTeleporter: Area2D
@export var action: String = "move_up"
@export var newScale: float = 1.0
@export var layer: int = 2

var disabled = false

func _ready():
	set_layer(layer)

func teleport_player():
	%StrawberryKnight.start_teleport_buffer(layer)
	
	%StrawberryKnight.remove_current_layer()
	%StrawberryKnight.global_position.y = global_position.y
	%StrawberryKnight.global_scale = Vector2(newScale, newScale)

# Sets the layer for both rendering and collision
func set_layer(new_layer: int):
	z_index = -1 * new_layer
	
	set_collision_mask_value(self.layer, false)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer

func _input(event):
	if event.is_action_pressed(action) and has_overlapping_bodies():
		pairedTeleporter.teleport_player()
