extends TileMapLayer
var last_tiled_id: int = -10
var TILE_HEIGHT = 100
func add_tile():
	last_tiled_id += 1
	set_cell(Vector2i(0,-last_tiled_id),0,Vector2i.ZERO,1)
