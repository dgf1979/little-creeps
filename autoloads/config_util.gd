extends Node

func load_map_data_for_path(path: String) -> MapData:
	var map_data = MapData.new()
	map_data.map_dir_name = path
	
	var fp = Constants.MAPS_PATH + "/" + path + "/" + Constants.MAP_CONFIG_FILE_NAME
	var cf = ConfigFile.new()
	var err = cf.load(fp)
	if err != OK:
		push_error("Unable to load config file: " + fp)
	
	map_data.map_name = cf.get_value("MapData","map_name",null)
	map_data.wall_mode = cf.get_value("MapData","wall_mode",null)
	
	var bitmap = ImageUtil.load_texture_resource_as_image(PathUtil.append(map_data.map_dir_path, Constants.MAP_BITMAP_FILE_NAME))
	for row in range(bitmap.get_height()):
		map_data.map_array.append([])
		for col in range(bitmap.get_width()):
			var px_color: Color = bitmap.get_pixel(col, row)
			var tile_value: Enums.TILE_TYPE = _get_tile_value_for_color(px_color)
			map_data.map_array[row].append(tile_value)
			if tile_value == Enums.TILE_TYPE.SPAWN:
				map_data.creep_spawn.append(Vector2i(col, row))
			if tile_value == Enums.TILE_TYPE.EXIT:
				map_data.creep_exit.append(Vector2i(col, row))
	
	#print_debug(map_data.map_to_debug_string())
	
	return map_data
	
func _get_tile_value_for_color(color: Color) -> Enums.TILE_TYPE:
	if color == Color.BLACK:
		return Enums.TILE_TYPE.PATH
	if color == Color.WHITE:
		return Enums.TILE_TYPE.WALL
	if color == Color.GREEN:
		return Enums.TILE_TYPE.SPAWN
	if color == Color.RED:
		return Enums.TILE_TYPE.EXIT
	if color == Color.BLUE:
		push_error("'Tower' tile type is not valid in bit map")
		return Enums.TILE_TYPE.INVALID
		
	push_error("No tile value found for pixel with color: " + var_to_str(color))
	return Enums.TILE_TYPE.INVALID
