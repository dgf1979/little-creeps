extends Node 
class_name LevelData

var map_data: MapData
var creep_data: Dictionary[String, CreepData]
var tower_data: Dictionary[String, TowerData]

func _ready() -> void:
	map_data = ConfigUtil.load_map_data_for_path(Selection.selected_map_dir)
	creep_data = ConfigUtil.load_creep_data_for_path(Selection.selected_map_dir)
	tower_data = ConfigUtil.load_tower_data_for_path(Selection.selected_map_dir)
