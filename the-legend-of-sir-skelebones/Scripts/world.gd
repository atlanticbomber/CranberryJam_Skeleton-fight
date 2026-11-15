extends Node2D
var map
@onready var character = $Skelebro
var timer
var spawn_loops = 0
var farthest_tile = 0

func _init():
	var tile_map = preload("res://Scenes/tile_map_layer.tscn")
	map = tile_map.instantiate()
	add_child(map)
	for i in range(-10,0):
		map.add_tile()
	timer = Timer.new()
	timer.timeout.connect(decay_map)
	add_child(timer)
	timer.autostart = true

func _process(delta: float) -> void:
	farthest_tile = min(character.global_position.y/100,farthest_tile)
	if -farthest_tile > map.last_tiled_id-7:
		map.add_tile()
	spawn_enemies(-farthest_tile)

func _ready() -> void:
	Music.changeMusic("Battle")
	map.game_over.connect(game_end)
	character.game_over.connect(game_end)
func decay_map():
	map.decay_next()
	timer.wait_time = 1.5 + 0.95 * (timer.wait_time - 1.5)
var enemy_template = preload("res://Scenes/enemy.tscn")
var enemy_count = 0

func spawn_enemies(distance):
	var enemy_capac = 20 + 3 * distance / 100
	var enemies_per_sec = 2 + 28 * (1 - 2 ** ((distance/400) ** 1.5))
	var random = randi_range(0,100)
	var rand_2 = randi_range(0,enemy_capac * 1.5)
	if random < enemies_per_sec and enemy_count<(enemy_capac) and enemy_count < rand_2:
		var enemy = enemy_template.instantiate()
		enemy.EN = choose_random_enemy(distance)
		var rand_x = randi_range(-900, 900)
		var rand_y = (distance + 6) * 100 + randi_range(0,200)
		enemy. global_position = Vector2(rand_x, -rand_y)
		enemy_count += 1
		enemy.dying.connect(func(): enemy_count -= 1)
		add_child(enemy)
		
func choose_random_enemy(distance)-> EnemyResource:
	return preload("res://Resources/Enemy/BasicEnemy.tres")
	
func game_end():
	call_deferred("load_end_screen")

func load_end_screen():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
