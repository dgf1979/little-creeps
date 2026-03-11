class_name Missile
extends Node2D

@export var sprite_sheet: Texture2D
@export var speed: float
@export var parent_tower_name: String

func _ready() -> void:
	assert(sprite_sheet, "sprite_sheet required")
	assert(speed, "speed required")
	assert(parent_tower_name, "parent_tower_name required")

var _target: Creep
var _launched = false
func launch_at(target: Creep) -> void:
	_target = target
	_launched = true

const _turn_speed = 20.0
var _velocity = Vector2.ZERO
var _target_last_position: Vector2
func _process(delta: float) -> void:
	# don't move until fired
	if not _launched: return
	
	# if the target dies before we get to it, home in on its last known position
	if _target: _target_last_position = _target.global_position
	
	var target_dir = (_target_last_position - global_position).normalized()
	_velocity = _velocity.lerp(target_dir * speed, _turn_speed * delta)
	rotation = _velocity.angle()
	global_position += _velocity * delta
	
	if global_position.distance_to(_target_last_position) < 16:
		_splode()
		
func _splode() -> void:
	Event.spawn_splosion.emit(parent_tower_name, _target_last_position)  
	queue_free()
