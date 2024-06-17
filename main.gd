extends Node2D

func _input(event):
	if event is InputEventKey and event.is_action_pressed("interact"):
		Dialogic.start("skyrim")

