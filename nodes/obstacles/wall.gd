extends StaticBody2D

@export var layer: int = 2

# render player into scene
func _ready():
	set_new_layer(layer)

func remove_current_layer():
	set_collision_layer_value(self.layer, false)
	set_collision_mask_value(self.layer, false)

func set_new_layer(new_layer: int):
	z_index = -1 * new_layer
	
	remove_current_layer()
	set_collision_layer_value(new_layer, true)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer
