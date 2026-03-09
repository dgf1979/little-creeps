class_name TowerData

enum Type { INVALID, WALL, BULLET, MISSILE, BEAM, PULSE }

var display_name: String = ""
var sprite_base_file_name: String = "" # file name of sprite 64x64px
var sprite_turret_file_name: String = "" # OPTIONAL: file name of rotating turret portion of tower
var thumbnail_file_name: String = "" # file name of thumbnail 64x64px
var has_turret: bool = false
var type: Type = Type.INVALID # projectile type
var target_range: int = 0 # projectile range
var projectile_sprite_file_name: String = ""
var projectile_firing_sound_file_name: String = ""
var rate_of_fire: float = 0.0
var damage_per_hit: int = 0

func load_sprite_base_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(sprite_base_file_name)
	return ResUtil.load_texture_resource(resource_path)
	
func load_sprite_turret_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(sprite_turret_file_name)
	return ResUtil.load_texture_resource(resource_path)
	
func load_thumbnail_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(thumbnail_file_name)
	return ResUtil.load_texture_resource(resource_path)
	
func load_projectile_sprite_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(projectile_sprite_file_name)
	return ResUtil.load_texture_resource(resource_path)
	
func load_firing_sound() -> AudioStream:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(projectile_firing_sound_file_name)
	return load(resource_path)
	
