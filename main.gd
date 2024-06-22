extends Node2D

const HubPath = "res://scenes/levels/hub/hub.tscn"

@onready var _animation_player = $AnimationPlayer

func _ready():
	_animation_player.queue("splash_screen")
	_animation_player.queue("title_screen")

func _input(event):
	if event is InputEventKey && event.is_pressed():
		if _animation_player.current_animation == "splash_screen":
			_animation_player.seek(_animation_player.get_animation("splash_screen").length)
		elif _animation_player.current_animation == "title_screen":
			_animation_player.seek(_animation_player.get_animation("title_screen").length)
		else:
			get_tree().change_scene_to_file(HubPath)
