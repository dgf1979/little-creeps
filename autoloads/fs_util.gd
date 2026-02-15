extends Node
	
func get_files_by_extension(path: String, extension: String) -> Array:
	var files = []
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(extension):
				files.append(path.path_join(file_name))
			file_name = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path: ", path)
		
	return files

func get_file_as_config(file_path: String) -> ConfigFile:
	var cf = ConfigFile.new()
	var err = cf.load(file_path)
	if err != OK:
		push_error("Unable to load config file: " + file_path)
	return cf
