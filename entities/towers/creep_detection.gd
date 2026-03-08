extends Area2D

func configure(tower_data: TowerData) -> void:
	# walls don't need to track creeps, so remove if that's the case
	match tower_data.type:
		TowerData.Type.WALL:
			queue_free()
			return
	
	var detection_shape: CollisionShape2D = $DetectionRadius
	var circle: CircleShape2D = detection_shape.shape
	circle.radius = tower_data.target_range
