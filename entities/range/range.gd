extends Node2D

const color: Color = Color(Color.ORANGE, 0.4)
const line_width: float = 4.0
@export var radius: float = 64.0
@export var offset: Vector2 = Vector2.ZERO 

func _draw():
	draw_arc(offset, radius, 0, TAU, 64, color, line_width, true)

func _process(_delta):
	# update every frame
	queue_redraw() 
