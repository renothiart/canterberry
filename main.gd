extends Node2D

const HubPath = "res://scenes/levels/hub/hub.tscn"

func _input(event):
	if event is InputEventKey:
		get_tree().change_scene_to_file(HubPath)
