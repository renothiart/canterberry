extends Node2D

func start_main_music():
	if not $MainMusicPlayer.playing:
		$MainMusicPlayer.play()

func stop_main_music():
	$MainMusicPlayer.stop()

func start_indoor_music():
	if not $IndoorMusicPlayer.playing:
		$IndoorMusicPlayer.play()

func stop_indoor_music():
	$IndoorMusicPlayer.stop()
