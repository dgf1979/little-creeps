extends Node
class_name CreepFactory

@onready var creep_catalog: Dictionary[String, CreepData] = %LevelData.creep_data

var _tracked_creeps: Dictionary[int, Creep] = {}

func _ready() -> void:
	Event.creep_elimination.connect(_on_creep_elimination)
	Event.creep_exit.connect(_on_creep_exit)
	Event.map_update.connect(_on_map_update)

func _build_creep(creep_data: CreepData) -> Creep:
	var scn: PackedScene = load("res://entities/creeps/creep.tscn")
	var creep_instance: Creep = scn.instantiate()
	creep_instance.configure(creep_data)
	creep_instance.set_path(%ActiveMap.get_global_path_from_spawn())
	_tracked_creeps.set(creep_instance.get_instance_id(), creep_instance)
	return creep_instance

#func _on_start_btn_pressed() -> void:
	#var creep_name = creep_catalog.keys()[1]
	#var creep1: Creep = _build_creep(creep_catalog[creep_name])
	#add_child(creep1)
	#Event.creep_spawn.emit(creep1)
	
func _on_creep_elimination(creep: Creep) -> void:
	_tracked_creeps.erase(creep.get_instance_id())
	creep.queue_free()
	
func _on_creep_exit(creep: Creep) -> void:
	_tracked_creeps.erase(creep.get_instance_id())
	creep.queue_free()
	
func _on_map_update(map: Map) -> void:
	for creep: Creep in _tracked_creeps.values():
		var new_start = %ActiveMap.global_to_map(creep.global_position)
		var nearest_exit = map.spawn_exit_get_nearest(new_start)
		var map_path = map.find_path(new_start, nearest_exit)
		var global_path = %ActiveMap.path_to_global(map_path)
		creep.set_path(global_path)
	
	


	
