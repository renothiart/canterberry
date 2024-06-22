extends Area2D

# interaction managers interact with each other
class_name InteractionManager
var interaction_partner: InteractionManager

# interaction managers signal to other nodes
signal enter_interaction
signal exit_interaction

# is this interactable object a PCC?
var is_pcc = false

@export var layer: int = 12
@export var width_scale: float = 1

func _ready():
	$CollisionShape2D.shape.radius *= width_scale

# call this on interaction controller input
func attempt_interaction(input: String) -> void:
	if interaction_partner != null:
		interaction_partner.interact(input)

# overwrite with interaction behavior for each interactable object
func interact(input: String) -> void:
	print("No behavior defined for this interaction")


# overwrite only when applicable
func interact_echo(key: String) -> void:
	print("No echo behavior defined for this interaction")


# connected to InteractionManager on_enter signal
func _on_Interaction_Manager_area_entered(area):
	enter_interaction.emit()
	interaction_partner = area


# connected to InteractionManager on_exit signal
func _on_Interaction_Manager_area_exited(area):
	exit_interaction.emit()
	if interaction_partner == area:
		interaction_partner = null

func remove_current_layer():
	set_collision_layer_value(self.layer, false)
	set_collision_mask_value(self.layer, false)

func set_new_layer(new_layer: int):
	remove_current_layer()
	set_collision_layer_value(new_layer, true)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer
