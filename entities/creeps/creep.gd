extends CharacterBody2D
class_name Creep

var token_value: int = 10
var hit_points: int = 20
var speed: int = 96
var _path: Array[Vector2] = []
var _path_count: = 0

#PUBLIC
func configure(creep_data: CreepData) -> void:
	%Sprite.configure_walk_animation(creep_data.load_walk_anim_texture())
	# TODO add token vale to creep config and class
	# TODO add hit points to creep config and class
	# TODO add speed (pixels per second) 
	# token_value = creep_data.token_value
	# hit_points = creep_data.hit_points
		
func set_path(global_path: Array[Vector2]) -> void:
	_path = global_path
	if _path_count == 0: position = _path[0]
	_path_count += 1

#PRIVATE
func _exit_reached() -> void:
	Event.creep_exit.emit(self)
	
func _destroyed() -> void:
	Event.creep_eliminated.emit(self)
	
func _process(_delta: float) -> void:
	# if no path, don't move
	if _path.is_empty(): return

	var direction: Vector2 = global_position.direction_to(_path[0])
	look_at(_path[0])
	velocity = direction * speed #pixels per second
	move_and_slide()
	
	# remove path node if we have reached it
	var distance = global_position.distance_to(_path[0])
	if distance < 1.0:
		_path.remove_at(0)
		# if the path is empty after removing the last segment, we've reached the end
		if _path.is_empty(): _exit_reached()
		
	

	
