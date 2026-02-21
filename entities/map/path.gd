extends RefCounted
class_name Path

var _grid = AStarGrid2D.new()

func _init() -> void:
	_grid.region = Rect2i(0, 0, Constants.MAP_TILE_WIDTH, Constants.MAP_TILE_HEIGHT)
	_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	_grid.update()

func sync(map: Map) -> void:
	for coord in map.coordinates():
		var solid = not map.walkable(coord)
		_grid.set_point_solid(coord, solid)
	
func find_path(from: Vector2i, to: Vector2i) -> Array[Vector2i]:
	var path = _grid.get_point_path(from, to)
	var converted: Array[Vector2i]
	converted.assign(path.duplicate())
	return converted
