extends Node2D

var latest_main_pos = 0.0
var latest_indoor_pos = 0.0

func is_playing_main_music():
	return $MainMusicPlayer.playing

func start_main_music():
	if not $MainMusicPlayer.playing:
		stop_indoor_music()
		$MainMusicPlayer.play(latest_main_pos)

func stop_main_music():
	latest_main_pos = $MainMusicPlayer.get_playback_position()
	$MainMusicPlayer.stop()

func is_playing_indoor_music():
	return $IndoorMusicPlayer.playing
	
func start_indoor_music():
	if not $IndoorMusicPlayer.playing:
		stop_main_music()
		$IndoorMusicPlayer.play(latest_indoor_pos)

func stop_indoor_music():
	latest_indoor_pos = $IndoorMusicPlayer.get_playback_position()
	$IndoorMusicPlayer.stop()
