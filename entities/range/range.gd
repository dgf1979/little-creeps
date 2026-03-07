extends Node2D

const color: Color = Color(Color.ORANGE, 0.3)
const line_width: float = 2.0
@export var radius: float = 50.0
@export var offset: Vector2 = Vector2(Constants.MAP_ACTOR_SIZE_PX * 0.5, Constants.MAP_ACTOR_SIZE_PX * 0.5)

func _draw():
	# draw_arc(center, radius, start_angle, end_angle, point_count, color, width, antialiased)
	draw_arc(offset, radius, 0, TAU, 64, color, line_width, true)

func _process(_delta):
	# update every frame
	queue_redraw() 
