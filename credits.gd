extends Node2D

const main_path = "res://main.tscn"

@onready var _animation_player = $AnimationPlayer

func _ready():
	_animation_player.queue("bard_show_fade_in")
	await _animation_player.animation_finished
	Dialogic.start("Bard-Show")
	await Dialogic.timeline_ended
	_animation_player.queue("bard_show_fade_out")
	_animation_player.queue("credits")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "credits":
		get_tree().change_scene_to_file(main_path)
