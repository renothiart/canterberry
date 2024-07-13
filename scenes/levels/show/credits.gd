extends Node2D

# main scene path to restart game
const main_path = "res://main.tscn"

@onready var _animation_player = $AnimationPlayer

func _ready():
	_animation_player.queue("credits")
	await _animation_player.animation_finished
	get_tree().change_scene_to_file(main_path)
