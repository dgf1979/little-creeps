extends Area2D

@onready var tower_data: TowerData = %Config.tower_data

func _ready() -> void:
	# walls don't need to track creeps, so remove if that's the case
	match tower_data.type:
		TowerData.Type.WALL:
			queue_free()
			return
	
	var detection_shape: CollisionShape2D = $DetectionRadius
	var circle: CircleShape2D = detection_shape.shape
	circle.radius = tower_data.target_range
