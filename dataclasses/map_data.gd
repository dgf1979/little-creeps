class_name MapData

enum WallMode { SIMPLE, COMPLEX }

var map_dir_name: String
var map_dir_path: String:
	get: 
		return PathUtil.append(Constants.MAPS_PATH, map_dir_name)
var map_name: String
var creep_spawn: Array[Vector2i] = []
var creep_exit: Array[Vector2i] = []
var wall_mode: WallMode = WallMode.SIMPLE
var map_array: Array[Array] = [[]]

const _block_char = "\u2588" # character code for solid block

func load_preview_image() -> Texture2D:
	var resource_path = PathUtil.append(map_dir_path, Constants.MAP_PREVIEW_FILE_NAME)
	return ImageUtil.load_texture_resource(resource_path)
	
func load_map_image() -> Texture2D:
	var resource_path = PathUtil.append(map_dir_path, Constants.MAP_IMAGE_FILE_NAME)
	return ImageUtil.load_texture_resource(resource_path)

func to_dict() -> Dictionary:
	var d = {}
	d.set("map_dir_name", map_dir_name)
	d.set("map_name", map_name)
	d.set("creep_spawn", creep_spawn)
	d.set("creep_exit", creep_exit)
	d.set("wall_mode", wall_mode)
	d.set("map_array", map_array)
	return d
	
func map_to_debug_string() -> String:
	var outstring = ""
	for row in range(map_array.size()):
		for col in range(map_array[row].size()):
			var tile_number = map_array[row][col]
			var c
			match tile_number:
				Enums.TILE_TYPE.INVALID:
					c = "!"
				Enums.TILE_TYPE.PATH:
					c = " "
				Enums.TILE_TYPE.SPAWN:
					c = "S"
				Enums.TILE_TYPE.EXIT:
					c = "E"
				Enums.TILE_TYPE.WALL:
					c = _block_char
				_:
					c = "?"
			outstring += c
		outstring += "\n"
	outstring += "KEY: ! = Invalid, ' ' = Walkable (empty), S = Creep Spawn, E = Creep Exit, " + _block_char + " = Unwalkable (wall)"
	return outstring
				
