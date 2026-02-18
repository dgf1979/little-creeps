extends TileMapLayer
class_name ActiveMap

func _ready() -> void:
	clear()
	for x in range(Constants.MAP_TILE_WIDTH):
		for y in range(Constants.MAP_TILE_HEIGHT):
			set_cell(Vector2i(x, y), 0, Vector2i(0,0))

func tilemap_to_global(xy: Vector2i) -> Vector2:
	return to_global(map_to_local(xy))
	
func tilemap_from_global(global_pos: Vector2) -> Vector2i:
	return local_to_map(to_local(global_pos))

func path_to_global(path: Array[Vector2i]) -> Array[Vector2]:
	var converted: Array[Vector2] = []
	for v2i in path:
		converted.append(tilemap_to_global(v2i))
	return converted

# return the integer id of a tile, or -1 if the cursor is not currently over a tile	
func _hovered_tile_id() -> int:
	return get_cell_source_id(local_to_map(get_local_mouse_position()))

# by default tilemap position is the center of the tile, but in this case we want the upper-left position,
# and therefor need to subtract half the tile width & height from each position
const offset = Vector2(Constants.MAP_TILE_SIZE_PX * 0.5, Constants.MAP_TILE_SIZE_PX * 0.5)
const NO_TILE = -1 #disambiguate the magic number for no tile
func cursor_snap_to_map(cursor: TowerPacementCursor) -> void:
	if _hovered_tile_id() == NO_TILE:
		cursor.position = get_global_mouse_position()
		return
	
	# since the cursor sprite is 2x larger than a cell in both directions, snap it to the prior row/column of the grid	
	var tile_map_pos = tilemap_from_global(get_global_mouse_position())
	if tile_map_pos.x == Constants.MAP_TILE_WIDTH - 1 or tile_map_pos.y == Constants.MAP_TILE_HEIGHT - 1:
		tile_map_pos -= Vector2i(1, 1)
	
	#snap the cursor to the grid
	var snapped_position = tilemap_to_global(tile_map_pos) - offset 
	cursor.position = snapped_position
