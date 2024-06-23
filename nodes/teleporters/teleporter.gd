extends Area2D

@export var pairedTeleporter: Area2D
@export var newScale: float = 1.0
@export var layer: int = 2

var disabled = false

# required variables enabling teleporting
var teleport_buffer_time: float = 0.2
var teleport_buffer_time_remaining: float = 0

func _ready():
	set_layer(layer)

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

func teleport_player():
	disable()
	%Player.start_teleport_buffer(layer)
	
	%Player.remove_current_layer()
	%Player.global_position = global_position
	%Player.global_scale = Vector2(newScale, newScale)

# Sets the layer for both rendering and collision
func set_layer(new_layer: int):
	z_index = -1 * new_layer
	
	set_collision_mask_value(self.layer, false)
	set_collision_mask_value(new_layer, true)
	
	self.layer = new_layer

func _on_body_entered(body):
	if body.name == "Player" and not disabled:
		pairedTeleporter.teleport_player()

func _on_body_exited(_body):
	enable()

func disable():
	disabled = true

func enable():
	disabled = false
