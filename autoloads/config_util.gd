extends Node

func load_map_data_for_path(map_dir_name: String) -> MapData:
	var map_data = MapData.new()
	map_data.map_dir_name = map_dir_name
	
	var map_path = Constants.MAPS_PATH.path_join(map_dir_name)
	var fp = map_path.path_join(Constants.MAP_CONFIG_FILE_NAME)
	var cfg = FSUtil.get_file_as_config(fp)
	
	map_data.map_name = cfg.get_value("MapData","map_name",null)
	map_data.wall_mode = cfg.get_value("MapData","wall_mode",null)
	map_data.preview_image = load_texture(Constants.MAP_PREVIEW_FILE_NAME, map_path)
	map_data.map_image = load_texture(Constants.MAP_IMAGE_FILE_NAME, map_path)
	
	var bitmap = ResUtil.load_texture_resource_as_image(map_data.map_dir_path.path_join(Constants.MAP_BITMAP_FILE_NAME))
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
		creep.walk_anim_texture = load_texture(cfg.get_value("Creep","walk_anim_file_name"), creep_dir_path)
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
		tower.sprite_base_texture = load_texture(cfg.get_value("Tower", "sprite_base_file_name"), tower_dir_path)
		tower.thumbnail_texture = load_texture(cfg.get_value("Tower", "thumbnail_file_name"), tower_dir_path)
		tower.type = _get_tower_enum_type(cfg.get_value("Tower", "type"))
		tower.target_range = cfg.get_value("Tower", "range")
		# optional turret section
		if cfg.has_section("Turret"):
			tower.has_turret = true
			tower.sprite_turret_texture = load_texture(cfg.get_value("Turret", "sprite_turret_file_name"), tower_dir_path)
		# projectile type section - not required if type is 'WALL'
		if tower.type != TowerData.Type.WALL:
			tower.projectile_sprite_texture = load_texture(cfg.get_value("Projectile", "texture_file_name"), tower_dir_path)
			tower.projectile_sprite_fps = cfg.get_value("Projectile", "texture_animation_fps")
			tower.rate_of_fire = cfg.get_value("Projectile", "rate_of_fire")
			tower.damage_per_hit = cfg.get_value("Projectile", "damage_per_hit")
			tower.projectile_shoot_sound = load_sound(cfg.get_value("Projectile", "fire_sound_file_name"), tower_dir_path)
		if tower.type == TowerData.Type.MISSILE:
			tower.missile_explosion_blast_radius = cfg.get_value("Projectile", "missile_explosion_blast_radius")
			tower.missile_explosion_sprite_texture = load_texture(cfg.get_value("Projectile", "missile_explosion_sprite_texture_file_name"), tower_dir_path)
			tower.missile_explosion_sprite_animation_fps = cfg.get_value("Projectile", "missile_explosion_sprite_animation_fps")
			tower.missile_fly_speed = cfg.get_value("Projectile", "missile_fly_speed")
		tower_data.set(tower.display_name, tower)
	return tower_data
	
func _get_tower_enum_type(type_str: String) -> TowerData.Type:
	match type_str.to_upper():
		"WALL": return TowerData.Type.WALL
		"BULLET": return TowerData.Type.BULLET
		"MISSILE": return TowerData.Type.MISSILE
		"BEAM": return TowerData.Type.BEAM
		"PULSE": return TowerData.Type.PULSE
		_: 
			push_error("Unknown tower type '" + type_str + "'")
			return TowerData.Type.INVALID		

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
	
func load_texture(file_name: String, dir: String) -> Texture2D:
	var resource_path = dir.path_join(file_name)
	return ResUtil.load_texture_resource(resource_path)
	
func load_sound(file_name: String, dir: String) -> AudioStream:
	var resource_path = dir.path_join(file_name)
	return ResUtil.load_audio_resource(resource_path)
