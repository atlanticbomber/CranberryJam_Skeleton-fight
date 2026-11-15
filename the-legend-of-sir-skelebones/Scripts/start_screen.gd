extends Node2D
func _ready() -> void:
	Music.changeMusic("Menu")
func begin_run():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
