extends Node2D

# Export variables to adjust radius and color in the inspector
const color: Color = Color(Color.ORANGE, 0.3)
@export var radius: float = 50.0
const line_width: float = 2.0
const offset: Vector2 = Vector2(Constants.MAP_ACTOR_SIZE_PX * 0.5, Constants.MAP_ACTOR_SIZE_PX * 0.5)

func _draw():
	if radius == 0: return
	# draw_arc(center, radius, start_angle, end_angle, point_count, color, width, antialiased)
	draw_arc(offset, radius, 0, TAU, 64, color, line_width, true)

func _process(_delta):
	if radius == 0: return
	# update every frame
	queue_redraw() 


func _on_click_zone_mouse_entered() -> void:
	visible = true


func _on_click_zone_mouse_exited() -> void:
	visible = false
