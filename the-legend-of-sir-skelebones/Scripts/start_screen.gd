extends Node2D
func _ready() -> void:
	WeaponReset.reset()
	Music.changeMusic("Menu")
	
	
func begin_run():
	Stats.init_player_stats()
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
