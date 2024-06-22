extends Node2D

@export var item_type: Global.ItemType = Global.ItemType.NULL
@export var layer: int = 2
@export var new_scale: float = 1

func _ready():
	set_new_layer(layer)
	self.scale = Vector2(new_scale, new_scale)

func remove_current_layer():
	%InteractionManager.remove_current_layer()

func set_new_layer(new_layer: int):
	z_index = -1 * new_layer
	
	%InteractionManager.set_new_layer(new_layer + 10)
	
	self.layer = new_layer
