extends Node
class_name TowerFactory

@onready var tower_catalog: Dictionary[String, TowerData] = %LevelData.tower_data

func build_tower(tower_data: TowerData) -> Tower:
	var scn: PackedScene = load("res://entities/towers/tower.tscn")
	var tower_instance: Tower = scn.instantiate()
	tower_instance.configure(tower_data)
	return tower_instance
