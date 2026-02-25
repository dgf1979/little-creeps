extends TileMapLayer
class_name ActiveMap

@onready var map: Map = %MapFactory.get_map()

func _ready() -> void:
	Event.creep_spawn.connect(_on_creep_spawn)
	Event.tower_place.connect(_on_tower_place)
	clear() 
	for coordinate in map.coordinates():
		set_cell(coordinate, 0, Vector2i(0,0))
		
func get_global_path_from_spawn() -> Array[Vector2]:
	var start = map.spawn_point_get_next()
	var end = map.spawn_exit_get_nearest(start) 
	var map_path = map.find_path(start, end)
	var global_path = path_to_global(map_path)
	return global_path.duplicate()

func tilemap_to_global(xy: Vector2i) -> Vector2:
	return to_global(map_to_local(xy))
	
func tilemap_from_global(global_pos: Vector2) -> Vector2i:
	return local_to_map(to_local(global_pos))

func path_to_global(path: Array[Vector2i]) -> Array[Vector2]:
	var converted: Array[Vector2] = []
	for v2i in path:
		converted.append(tilemap_to_global(v2i))
	return converted

func global_to_map(global_pos: Vector2) -> Vector2i:
	return tilemap_from_global(global_pos)

# return the integer id of a tile, or -1 if the cursor is not currently over a tile	
func _hovered_tile_id() -> int:
	return get_cell_source_id(local_to_map(get_local_mouse_position()))

# by default tilemap position is the center of the tile, but in this case we want the upper-left position,
# and therefor need to subtract half the tile width & height from each position
const TILE_OFFSET = Vector2(Constants.MAP_TILE_SIZE_PX * 0.5, Constants.MAP_TILE_SIZE_PX * 0.5)
const ACTOR_OFFSET = Vector2(Constants.MAP_ACTOR_SIZE_PX * 0.5, Constants.MAP_ACTOR_SIZE_PX * 0.5)
const NO_TILE = -1 #disambiguate the magic number for no tile
func cursor_snap_to_map(cursor: TowerPacementCursor) -> void:
	# outside the tilemap, do not snap
	if _hovered_tile_id() == NO_TILE:
		# adjust the actual cursor to half the size the cursor sprite to roughly center
		cursor.position = get_global_mouse_position() - ACTOR_OFFSET
		cursor.can_place_tower(false)
		return
	
	# inside the tile map, translate teh real cursor position to the hovered tile grid position
	var tile_map_pos = tilemap_from_global(get_global_mouse_position())
	
	# since the cursor sprite is 2x larger than a cell in both directions,
	# translate it to the prior row/column of the grid when it is over the last x/y grid position
	if tile_map_pos.x == Constants.MAP_TILE_WIDTH - 1 or tile_map_pos.y == Constants.MAP_TILE_HEIGHT - 1:
		tile_map_pos -= Vector2i(1, 1)
		
	# snap the cursor to the grid
	var snapped_position = tilemap_to_global(tile_map_pos) - TILE_OFFSET
	cursor.position = snapped_position
	
	# get the 4 tiles overlapped by the sprite cursor	
	var hovered_tiles = _get_hovered_tiles_for(tile_map_pos)
	
	# block placement if there is already a tower/wall under the cursor
	if not map.all_buildable(hovered_tiles):
		cursor.can_place_tower(false)
		return
	
	# block placement if doing so would cause there to be no paths from spawn to exit
	if map.would_block_path(hovered_tiles):
		cursor.can_place_tower(false)
		return
		
	# block placement if there is a creep walking under the cursor
	# TODO
	
	cursor.can_place_tower(true)
	
# hovered tiles are the 2x2 tile area beneath the selection cursor sprite	
func _get_hovered_tiles_for(map_pos: Vector2i) -> Array[Vector2i]:
	var tiles : Array[Vector2i] = [map_pos, Vector2i(map_pos.x + 1, map_pos.y), Vector2i(map_pos.x, map_pos.y + 1), Vector2i(map_pos.x + 1, map_pos.y + 1)]
	return tiles
		
func _on_creep_spawn(creep: Creep) -> void:
	var path = get_global_path_from_spawn()
	creep.set_path(path)
	creep.start()
	
func _on_tower_place(tower_data: TowerData):
	var tower: Tower = (%TowerFactory as TowerFactory).build_tower(tower_data)
	var map_position = local_to_map(to_local(get_global_mouse_position()))
	var hovered_tiles = _get_hovered_tiles_for(map_position)
	map.set_blocked(hovered_tiles)
	tower.position = map_position * Constants.MAP_TILE_SIZE_PX
	add_child(tower)
	
