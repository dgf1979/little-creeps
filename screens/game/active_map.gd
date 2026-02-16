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
