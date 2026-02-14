extends Node
class_name PathFinder

var _grid = AStarGrid2D.new()

func _ready() -> void:
	_grid.region = Rect2i(0, 0, Constants.MAP_TILE_WIDTH, Constants.MAP_TILE_HEIGHT)
	_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	_grid.update()
	
	var map_data := (%LevelData as LevelData).map_data
	
	for rowcount in range(map_data.map_array.size()):
		var row = map_data.map_array[rowcount]
		for colcount in range(row.size()):
			var col = row[colcount]
			var tile_type: Enums.TILE_TYPE = col
			var grid_cell = Vector2i(colcount, rowcount)
			match tile_type:
				Enums.TILE_TYPE.WALL, Enums.TILE_TYPE.TOWER:
					_grid.set_point_solid(grid_cell)

func find_path(from: Vector2i, to: Vector2i) -> PackedVector2Array:
	var path = _grid.get_point_path(from, to)
	return path.duplicate()
	
