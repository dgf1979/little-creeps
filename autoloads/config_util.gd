extends Node

func load_map_data_for_path(map_dir_name: String) -> MapData:
	var map_data = MapData.new()
	map_data.map_dir_name = map_dir_name
	
	var fp = Constants.MAPS_PATH.path_join(map_dir_name).path_join(Constants.MAP_CONFIG_FILE_NAME)
	var cfg = FSUtil.get_file_as_config(fp)
	
	map_data.map_name = cfg.get_value("MapData","map_name",null)
	map_data.wall_mode = cfg.get_value("MapData","wall_mode",null)
	
	var bitmap = ImageUtil.load_texture_resource_as_image(map_data.map_dir_path.path_join(Constants.MAP_BITMAP_FILE_NAME))
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
	
func load_creep_data_for_path(map_dir_name: String) -> Dictionary[String, CreepData]:
	var creep_data: Dictionary[String, CreepData]
	var creep_dir_path = Constants.MAPS_PATH.path_join(map_dir_name).path_join("creeps")
	var creep_config_files = FSUtil.get_files_by_extension(creep_dir_path, ".cfg")
	for creep_config_file in creep_config_files:
		var cfg = FSUtil.get_file_as_config(creep_config_file)
		var creep = CreepData.new()
		creep.name = cfg.get_value("Creep","name")
		creep.walk_anim_file_name = cfg.get_value("Creep","walk_anim_file_name")
		creep_data.set(creep.name, creep)
	return creep_data
	
func load_tower_data_for_path(map_dir_name: String) -> Dictionary[String, TowerData]:
	var tower_data: Dictionary[String, TowerData]
	var tower_dir_path = Constants.MAPS_PATH.path_join(map_dir_name).path_join("towers")
	var tower_config_files = FSUtil.get_files_by_extension(tower_dir_path, ".cfg")
	for tower_config_file in tower_config_files:
		var cfg = FSUtil.get_file_as_config(tower_config_file)
		var tower = TowerData.new()
		tower.display_name = cfg.get_value("Tower", "display_name")
		tower.sprite_file_name = cfg.get_value("Tower", "sprite_file_name")
		tower.thumbnail_file_name = cfg.get_value("Tower", "thumbnail_file_name")
		tower_data.set(tower.display_name, tower)
	return tower_data

func load_wave_data_for_path(map_dir_name: String) -> Array[WaveData]:
	var wave_data_config_file_path = Constants.MAPS_PATH.path_join(map_dir_name).path_join(Constants.MAP_WAVE_CONFIG_FILE_NAME)
	var cfg = FSUtil.get_file_as_config(wave_data_config_file_path)
	var waves: Array[WaveData] = []
	for i in range(1, 99):
		var wave_section_name = "Wave" + str(i)
		if not cfg.has_section(wave_section_name): break
		var wave_data := WaveData.new()
		wave_data.count = cfg.get_value(wave_section_name, "count")
		wave_data.creep_name = cfg.get_value(wave_section_name, "creep_name")
		wave_data.duration = cfg.get_value(wave_section_name, "duration")
		waves.append(wave_data)

	return waves
	
