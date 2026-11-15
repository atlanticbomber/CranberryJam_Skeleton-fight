extends TileMapLayer
var decay_start: int = -10
var decay_current: int = decay_start
var last_tiled_id: int = decay_start
var TILE_HEIGHT = 100
signal game_over

	

func add_tile():
	last_tiled_id += 1
	set_cell(Vector2i(-0,-last_tiled_id),0,Vector2i.ZERO,1)

func decay_next():
	decay_current += 1
	set_cell(Vector2i(-0,-decay_current),0,Vector2i.ZERO,2)
