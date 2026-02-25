extends RefCounted
class_name Map

const _TT = Enums.TILE_TYPE
var _map_data: MapData
var _path: Path = Path.new()

var _walkable: Dictionary[Vector2i, bool] = {} # tiles a creep can walk on
var _buildable: Dictionary[Vector2i, bool] = {} # tiles a tower can be placed on
var _type: Dictionary[Vector2i, _TT]

var spawns: Array[Vector2i]
var exits: Array[Vector2i]

func _init(map_data: MapData) -> void:
	_map_data = map_data
	spawns = map_data.creep_spawn
	exits = map_data.creep_exit
	var map = map_data.map_array
	for rowcount in range(map.size()):
		var row = map[rowcount]
		for colcount in range(row.size()):
			var map_coord = Vector2i(colcount, rowcount)
			var tile_type: _TT = row[colcount]
			_update_node(map_coord, tile_type)
					
	_path.sync(self)
	
func _update_node(map_coord: Vector2i, tile_type: Enums.TILE_TYPE) -> void:
	_type.set(map_coord, tile_type)
	match tile_type:
		_TT.INVALID:
			push_error("invalid tile type at " + str(map_coord))
		_TT.SPAWN, _TT.EXIT:
			# creeps must be able to walk on and through spawn point/exit, but can't place a tower on top as that would block.
			_walkable.set(map_coord, true)
			_buildable.set(map_coord, false)
		_TT.PATH:
			_walkable.set(map_coord, true)
			_buildable.set(map_coord, true)
		_TT.WALL, _TT.TOWER:
			_walkable.set(map_coord, false)
			_buildable.set(map_coord, false)
		_:
			push_error("unhandled tile type at " + str(map_coord))
				
func coordinates() -> Array[Vector2i]:
	return _type.keys()
				
func all_buildable(position_list: Array[Vector2i]) -> bool:
	for position in position_list:
		if not buildable(position):
			return false
	return true
	
func buildable(position: Vector2i) -> bool:
	return _buildable.has(position) and _buildable[position]
	
func walkable(position: Vector2i) -> bool:
	return _walkable[position]
	
func would_block_path(positions_to_block: Array[Vector2i]) -> bool:
	return _path.would_block(positions_to_block)
	
func set_blocked(positions_to_block: Array[Vector2i]) -> void:
	for position in positions_to_block:
		_update_node(position, _TT.TOWER)
	_path.sync(self)
	Event.map_update.emit(self)

var _last_spawn_point_idx = 0
func spawn_point_get_next() -> Vector2i:
	if _last_spawn_point_idx == _map_data.creep_spawn.size() -1:
		_last_spawn_point_idx = 0
	else:
		_last_spawn_point_idx += 1
	return _map_data.creep_spawn[_last_spawn_point_idx]

# using euclidian distance as a hueristic rather than generating multiple paths to save cycles here.			
func spawn_exit_get_nearest(start_position: Vector2i) -> Vector2i:
	var nearest: Vector2i
	# max possible distance is the map diagonal, so map X+Y is higher than any valid distance 
	var last_distance: float = Constants.MAP_TILE_HEIGHT + Constants.MAP_TILE_WIDTH
	for exit_position in _map_data.creep_exit:
		var distance = start_position.distance_to(exit_position)
		if distance < last_distance: 
			last_distance = distance
			nearest = exit_position
	return nearest
	
func find_path(from: Vector2i, to: Vector2i) -> Array[Vector2i]:
	return _path.find_path(from, to)

func get_type(coordinate: Vector2i) -> Enums.TILE_TYPE:
	return _type[coordinate]
