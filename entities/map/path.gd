extends RefCounted
class_name Path

var _grid := AStarGrid2D.new()
var _duplicate := AStarGrid2D.new()

var _start: Vector2i
var _end: Vector2i

func _init() -> void:
	_grid.region = Rect2i(0, 0, Constants.MAP_TILE_WIDTH, Constants.MAP_TILE_HEIGHT)
	_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	_grid.update()
	
	_duplicate.region = _grid.region
	_duplicate.default_compute_heuristic = _grid.default_compute_heuristic
	_duplicate.default_estimate_heuristic = _grid.default_estimate_heuristic
	_duplicate.diagonal_mode = _grid.diagonal_mode
	_duplicate.update()

func sync(map: Map) -> void:
	for coord in map.coordinates():
		var solid = not map.walkable(coord)
		_grid.set_point_solid(coord, solid)
		_duplicate.set_point_solid(coord, solid)
	_start = map.spawns[0]
	_end = map.exits[0]
	
func find_path(from: Vector2i, to: Vector2i) -> Array[Vector2i]:
	var path = _grid.get_id_path(from, to)
	return path.duplicate()
	
func would_block(proposed_update: Array[Vector2i]) -> bool:
	for point in proposed_update:
		_duplicate.set_point_solid(point, true)
	var path = _duplicate.get_id_path(_start, _end)
	var blocks = path.is_empty()
	
	for point in proposed_update:
		_duplicate.set_point_solid(point, false)
	return blocks
	
#func _debug_print() -> void:
	#print_debug("grid:")
	#for row in range(_grid.region.size.y):
		#var rowstring = ""
		#for col in range(_grid.region.size.x):
			#var ch = Constants.SOLID_BLOCK_CHAR if _grid.is_point_solid(Vector2i(col, row)) else " "
			#rowstring += ch 
		#print(rowstring)
	#print("")
	#print("dupe:")
	#for row in range(_duplicate.region.size.y):
		#var rowstring = ""
		#for col in range(_duplicate.region.size.x):
			#var ch = Constants.SOLID_BLOCK_CHAR if _duplicate.is_point_solid(Vector2i(col, row)) else " "
			#rowstring += ch 
		#print(rowstring)
		

	
