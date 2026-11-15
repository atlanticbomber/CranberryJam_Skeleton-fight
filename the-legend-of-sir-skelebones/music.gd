extends Node

func changeMusic(song:String):
	if song == "Menu":
		$Menu.play()
		$Playing.stop()
	elif song == "Battle":
		if not $Playing.playing:
			$Playing.play()
			$Menu.stop()
		$Playing.volume_db = -2
	elif song == "Skill":
		$Playing.volume_db = -8
	
