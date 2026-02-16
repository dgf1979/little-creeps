class_name CreepData

var name: String = ""
var walk_anim_file_name: String = "" # file name of sprite animation 64x64px per frame horizontal

func load_walk_anim_texture() -> Texture2D:
	var resource_path = Constants.MAPS_PATH.path_join(Selection.selected_map_dir).path_join("creeps").path_join(walk_anim_file_name)
	return ImageUtil.load_texture_resource(resource_path)
