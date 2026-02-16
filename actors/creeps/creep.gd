extends CharacterBody2D
class_name Creep

var token_value: int = 10
var hit_points: int = 20
var speed: int = 96
var _path: Array[Vector2]

#SIGNALS
signal on_exit_reached
signal on_destroyed(token_value: int)

#PUBLIC
func configure(creep_data: CreepData) -> void:
	%Sprite.configure_walk_animation(creep_data.load_walk_anim_texture())
	# TODO add token vale to creep config and class
	# TODO add hit points to creep config and class
	# TODO add speed (pixels per second) 
	# token_value = creep_data.token_value
	# hit_points = creep_data.hit_points
	
func update_path(path: Array[Vector2]) -> void:
	_path = path

#PRIVATE
func _exit_reached() -> void:
	on_exit_reached.emit()
	queue_free()
	
func _destroyed() -> void:
	on_destroyed.emit(token_value)
	
func _process(_delta: float) -> void:
	# if we reached the final node in the path, then we made it to the exit
	if _path.is_empty():
		_exit_reached()
		return

	var direction: Vector2 = global_position.direction_to(_path[0])
	look_at(_path[0])
	velocity = direction * speed #pixels per second
	move_and_slide()
	
	# remove path node if we have reached it
	var distance = global_position.distance_to(_path[0])
	if distance < 1.0:
		_path.remove_at(0)

		

	
