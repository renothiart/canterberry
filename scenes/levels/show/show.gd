extends Node

var portkey_map

# credits scene filepath to play credits
const credits_path = "res://scenes/levels/show/credits.tscn"

@onready var _animation_player = $AnimationPlayer

func _ready():
	remove_unflyered_characters()
	_animation_player.queue("fade_in")
	await _animation_player.animation_finished
	Dialogic.start("Bard-Show")
	await Dialogic.timeline_ended
	_animation_player.queue("fade_out")

func remove_unflyered_characters():
	if not Dialogic.VAR.Messenger.HasFlyeredKing:
		$King.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredJester:
		$Jester.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredBaker:
		$Baker.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredTownsfolk:
		$Townsfolk.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredBandit:
		$Bandit.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredMaid:
		$Maid.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredSquire:
		$Squire.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredWitch:
		$Witch.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredMonk:
		$Monk.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredMushroom:
		$Mushroom.queue_free()
	if not Dialogic.VAR.Messenger.HasFlyeredBird:
		$Bird.queue_free()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene_to_file(credits_path)
