extends Node2D

func _input(event):
	if event is InputEventKey:
		get_tree().change_scene_to_file("res://level_scenes/hub/hub.tscn")
