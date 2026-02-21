extends Node
# signals are used elsewhere, not in the bus itself
# warnings cannot be excluded per-file, so must annotate each new signal
# (warning-ignore-all is proposed but not implemented as of Godot 4.6)

#TOWER
@warning_ignore("unused_signal")
signal tower_select(tower_data: TowerData)
@warning_ignore("unused_signal")
signal tower_place(tower_data: TowerData)
@warning_ignore("unused_signal")
signal tower_select_cancel()

#MAP/PATH
@warning_ignore("unused_signal")
signal map_update(map: Map)

#CREEP
@warning_ignore("unused_signal")
signal creep_spawn(creep: Creep)
@warning_ignore("unused_signal")
signal creep_exit(creep: Creep)
@warning_ignore("unused_signal")
signal creep_elimination(creep: Creep)







# debugging
func _ready() -> void:
	tower_select.connect(func(_x): print_debug("tower_select"))
	tower_place.connect(func(_x): print_debug("tower_place"))
	tower_select_cancel.connect(func(): print_debug("tower_select_cancel"))
	
	map_update.connect(func(_x): print_debug("map_update"))
	
	creep_spawn.connect(func(_x): print_debug("creep_spawn"))
	creep_exit.connect(func(_x): print_debug("creep_exit"))
	creep_elimination.connect(func(_x): print_debug("creep_elimination"))
