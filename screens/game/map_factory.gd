extends Node
class_name MapFactory

#effectively a singleton since there's only ever one map in the scene

var _map: Map

func get_map() -> Map:
	if _map == null:
		var map_data: MapData = %LevelData.map_data
		_map = Map.new(map_data)
	return _map
