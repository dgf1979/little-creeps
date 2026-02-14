extends Node 
class_name LevelData

var map_data: MapData

func _ready() -> void:
	map_data = ConfigUtil.load_map_data_for_path(Selection.selected_map_dir)
