extends Node2D

const hub_path = "res://scenes/levels/hub/hub.tscn"

@onready var _animation_player = $AnimationPlayer

func _ready():
	# TODO reset game
	_animation_player.queue("splash_screen")
	_animation_player.queue("title_screen")

func _input(event):
	if event is InputEventKey && event.is_pressed():
		if _animation_player.current_animation == "splash_screen":
			_animation_player.seek(_animation_player.get_animation("splash_screen").length)
		else:
			get_tree().change_scene_to_file(hub_path)
