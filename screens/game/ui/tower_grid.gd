extends GridContainer

const TOWER_SELECT_SCN = preload("res://screens/game/ui/TowerSelect.tscn")

func _ready() -> void:
	for example in get_children(): example.queue_free()
	var tower_catalog = (%LevelData.tower_data as Dictionary[String, TowerData])
	for tower_name in tower_catalog.keys():
		_add_tower_select(tower_catalog.get(tower_name))
		
func _add_tower_select(tower_data: TowerData) -> void:
	var instance: TowerSelect = TOWER_SELECT_SCN.instantiate()
	instance.setup(tower_data)
	add_child(instance)
