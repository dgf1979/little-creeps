extends Node2D

func configure(tower_data: TowerData) -> void:
	# walls don't shoot, so remove if that's the case
	match tower_data.type:
		TowerData.Type.WALL:
			queue_free()
			return
