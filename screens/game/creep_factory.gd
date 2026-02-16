extends Node
class_name CreepFactory

@onready var creep_catalog: Dictionary[String, CreepData] = %LevelData.creep_data
@onready var map_data: MapData = %LevelData.map_data
@onready var path_finder: PathFinder = %PathFinder

#PUBLIC

#PRIVATE
func _build_creep(creep_data: CreepData) -> Creep:
	var scn: PackedScene = load("res://actors/creeps/creep.tscn")
	var creep_instance: Creep = scn.instantiate()
	creep_instance.configure(creep_data)
	var tile_path = path_finder.find_path(map_data.creep_spawn[0], map_data.creep_exit[0])
	var global_path = %ActiveMap.path_to_global(tile_path)
	creep_instance.position = global_path[0]
	creep_instance.update_path(global_path)
	return creep_instance

#SIGNALS
func _on_start_btn_pressed() -> void:
	var creep_name = creep_catalog.keys()[1]
	var creep1: Creep = _build_creep(creep_catalog[creep_name])
	add_child(creep1)
