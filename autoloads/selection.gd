extends Node

# persists the file path of the directory for the selected map (level)
# set when a level is selected,
# read when the 'game' scene loads 
var selected_map_dir: String = "":
	set(new_value):
		selected_map_dir = new_value
	get:
		if selected_map_dir.strip_edges().is_empty():
			print_debug("no map directory path has been set!")
		return selected_map_dir
