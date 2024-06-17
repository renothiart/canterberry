extends Area2D

@export var pairedTeleporter: Area2D
@export var linkedLevel: PackedScene
@export var newScale: float = 1.0
@export var layer: int = 2

var disabled = false

func _ready():
	set_layer(layer)

func teleport_player():
	disabled = true
	%StrawberryKnight.start_teleport_buffer(layer)
	
	%StrawberryKnight.remove_current_layer()
	%StrawberryKnight.global_position = global_position
	%StrawberryKnight.global_scale = Vector2(newScale, newScale)

# Sets the layer for both rendering and collision
func set_layer(new_layer: int):
	z_index = -1 * new_layer
	
	set_collision_mask_value(self.layer, false)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer

func _on_body_entered(_body):
	if not disabled:
		pairedTeleporter.teleport_player()

func _on_body_exited(_body):
	disabled = false
