class_name TowerData

var display_name: String = ""
var sprite_file_name: String = "" # file name of sprite 64x64px, or 128x64px for towers with rotating tops
var thumbnail_file_name: String = "" # file name of thumbnail 64x64px

func load_sprite_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(sprite_file_name)
	return ImageUtil.load_texture_resource(resource_path)
	
func load_thumbnail_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("towers").path_join(thumbnail_file_name)
	return ImageUtil.load_texture_resource(resource_path)
	
