extends TileMapLayer

@onready var map: Map = %MapFactory.get_map()

const walkable_color = Color(0.0,0.0,0.0,0.7)
const blocked_color = Color(1.0,1.0,1.0,0.7)
const spawn_color = Color(0.0,1.0,0.0,0.7)
const exit_color = Color(1.0,0.0,0.0,0.7)
const path_color = Color.BLUE

func refresh() -> void:
	queue_redraw()
	
func _draw() -> void:
	for coord in map.coordinates():
		var tile_type: Enums.TILE_TYPE = map.get_type(coord)
		var tile_rect = get_tile_rect_at_pos(coord)
		var color = walkable_color
		match tile_type:
			Enums.TILE_TYPE.WALL:
				color = blocked_color
			Enums.TILE_TYPE.SPAWN:
				color = spawn_color
			Enums.TILE_TYPE.EXIT:
				color = exit_color
		
		draw_rect(tile_rect, color)
			
	var path = map.find_path(map.spawn_point_get_next(), map.spawn_exit_get_nearest(map.spawn_point_get_next()))
	
	for i in range(path.size()):
		if i >= path.size() - 1: return
		var a = map_to_local(path[i])
		var b = map_to_local(path[i + 1])
		draw_line(a, b, path_color, 4.0)
	
func get_tile_rect_at_pos(map_pos: Vector2) -> Rect2:
	var top_left = map_to_local(map_pos)
	var half_tile = tile_set.tile_size.x * 0.5
	top_left = top_left - Vector2(half_tile, half_tile)
	return Rect2(top_left, tile_set.tile_size)

func _on_visibility_changed() -> void:
	refresh()
