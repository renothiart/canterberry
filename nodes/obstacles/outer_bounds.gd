extends Node2D

func _on_reset_area_body_entered(body):
	if body.has_method("start_teleport_buffer"):
		var parent = get_parent()
		if parent.has_method("enable_portkeys"):
			parent.enable_portkeys()
