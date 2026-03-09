extends Node2D

const color: Color = Color(Color.ORANGE, 0.3)
const line_width: float = 2.0
var radius: float = 32.0
var offset: Vector2 = Vector2.ZERO 

func configure(tower_data: TowerData) -> void:
	# walls don't need to track creeps, so remove if that's the case
	match tower_data.type:
		TowerData.Type.WALL:
			queue_free()
			return
	
	radius = tower_data.target_range

func _draw():
	draw_arc(offset, radius, 0, TAU, 64, color, line_width, true)

func _process(_delta):
	# update every frame
	queue_redraw() 
