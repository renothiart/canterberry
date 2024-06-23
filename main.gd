extends Node2D

const hub_path = "res://scenes/levels/hub/hub.tscn"

@onready var _animation_player = $AnimationPlayer

var on_title = false
var on_controls = false

func _ready():
	Global.reset_game()
	
	_animation_player.queue("splash_screen")
	_animation_player.queue("title_screen_fade_in")

func _input(event):
	if event is InputEventKey && event.is_pressed():
		if _animation_player.current_animation == "splash_screen":
			on_title = true
			_animation_player.seek(_animation_player.get_animation("splash_screen").length)
		elif on_title:
			on_title = false
			on_controls = true
			_animation_player.seek(_animation_player.get_animation("title_screen_fade_in").length)
			_animation_player.queue("title_screen_to_controls_screen")
		elif on_controls:
			on_controls = false
			_animation_player.seek(_animation_player.get_animation("title_screen_to_controls_screen").length)
			_animation_player.queue("controls_screen_fade_out")
			await _animation_player.animation_finished
			get_tree().change_scene_to_file(hub_path)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "title_screen_fade_in":
		on_title = true
	elif anim_name == "control_screen_fade_in":
		on_controls = true
