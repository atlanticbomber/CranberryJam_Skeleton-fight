
extends Node2D
@onready var collapsed = false
@onready var death_check = $Area2D

func _ready() -> void:
	$AnimationPlayer.play("fall")
	await $AnimationPlayer.animation_finished
	collapsed = true


func handle_player_entrance(body: Node2D):
	if body is Player and collapsed:
		call_deferred("load_menu")
	elif body is Enemy and collapsed:
		body.EnemyDamage(body.MaxEnemyHP)

func load_menu():
	#get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
	get_parent().game_over.emit()

func done_collapsing() -> void:
	collapsed = true
