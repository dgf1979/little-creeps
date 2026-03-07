class_name TowerData

enum Type { INVALID, WALL, BULLET, MISSILE, BEAM, PULSE }

var display_name: String = ""
var sprite_base_file_name: String = "" # file name of sprite 64x64px
var sprite_turret_file_name: String = "" # OPTIONAL: file name of rotating turret portion of tower
var thumbnail_file_name: String = "" # file name of thumbnail 64x64px
var has_turret: bool = false
var type: Type = Type.INVALID # projectile type
var range: int = 0 # projectile range

func load_sprite_base_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(sprite_base_file_name)
	return ImageUtil.load_texture_resource(resource_path)
	
func load_sprite_turret_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(sprite_turret_file_name)
	return ImageUtil.load_texture_resource(resource_path)
	
func load_thumbnail_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(thumbnail_file_name)
	return ImageUtil.load_texture_resource(resource_path)
	
