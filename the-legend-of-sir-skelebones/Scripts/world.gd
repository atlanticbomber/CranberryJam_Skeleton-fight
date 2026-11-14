extends Node2D
var map
@onready var character = $Skelebro
func _init():
	var tile_map = preload("res://Scenes/tile_map_layer.tscn")
	map = tile_map.instantiate()
	add_child(map)
	for i in range(-10,10):
		map.add_tile()

func _process(delta: float) -> void:
	var farthest_tile = character.global_position.y/100
	if -farthest_tile < map.last_tiled_id-7:
		map.add_tile()
