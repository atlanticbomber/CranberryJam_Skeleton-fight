
extends Node2D
@onready var collapsed = false
@onready var death_check = $Area2D


func handle_player_entrance(body: Node2D):
	if body is Player and collapsed:
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")



func done_collapsing() -> void:
	collapsed = true
