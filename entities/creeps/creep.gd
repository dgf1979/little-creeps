extends CharacterBody2D
class_name Creep

var token_value: int = 10
var hit_points: int = 20
var speed: int = 64
var _path: Array[Vector2] = []
var _started: bool = false

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
	
func start() -> void:
	if _path.is_empty(): push_error("must set a path before calling start!")
	_fudge(_path[0])
	position = _path[0]
	var random_start_delay = randf_range(0.0, 2.0)
	await get_tree().create_timer(random_start_delay).timeout
	_started = true
	visible = true

#PRIVATE

# the path is center of each tile, but I want to spead the creeps out a bit
func _fudge(pos: Vector2) -> void:
	var offset = Vector2(randi_range(-15, 15), randi_range(-15, 15))
	pos += offset

func _ready() -> void:
	visible = false # hide until we start

func _exit_reached() -> void:
	Event.creep_exit.emit(self)
	
func _destroyed() -> void:
	Event.creep_eliminated.emit(self)
	
func _process(_delta: float) -> void:
	# if not started, don't move
	if not _started: return

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
		
	

	
