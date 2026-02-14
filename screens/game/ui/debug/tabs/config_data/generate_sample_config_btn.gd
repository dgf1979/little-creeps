extends Button

func _on_pressed() -> void:
	var start: Array[Vector2] = [Vector2(0,0), Vector2(0,1)]
	var end: Array[Vector2] = [Vector2(0,0), Vector2(0,1)]
	var map: Array[Array] = []
	var md = MapData.new()
	md.map_name = "Sample Map"
	md.creep_spawn = start
	md.creep_exit = end
	md.map_dir_name = "NA"
	md.map_array = map
	md.wall_mode = MapData.WallMode.SIMPLE
	var cf := dictionary_to_config("MapData", md.to_dict())
	cf.save("user://example_map_data.cfg")
	var out = "Saved 'example_map_data_cfg to: " + ProjectSettings.globalize_path("user://")
	print(out)
	%GenerateSampleResult.text = out
	
func dictionary_to_config(section_name: String, dict: Dictionary) -> ConfigFile:
	var cf := ConfigFile.new() 
	for key in dict.keys():
		var val = dict.get(key)
		cf.set_value(section_name, key, val)
	return cf
	
