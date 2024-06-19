extends Area2D

@export var portkeyLocation: Global.PortkeyLocation
@export var pairedPortkeyLocation: Global.PortkeyLocation
@export var linkedLevelName: String
@export var newScale: float = 1.0
@export var layer: int = 2

var disabled = false

func _ready():
	set_layer(layer)

# Sets the layer for both rendering and collision
func set_layer(new_layer: int):
	z_index = -1 * new_layer
	
	set_collision_mask_value(self.layer, false)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer

func _on_body_entered(_body):
	if not disabled:
		Global.currentPortkeyLocation = pairedPortkeyLocation
		get_tree().change_scene_to_file(linkedLevelName)

func _on_body_exited(_body):
	disabled = false
