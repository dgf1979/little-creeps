class_name Missile
extends Node2D

const SPLOSION: PackedScene = preload("res://entities/splosion/splosion.tscn") 

@export var sprite_sheet: Texture2D
@export var speed: float = 200.0
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
	var splosion_instance: Splosion = SPLOSION.instantiate()
	get_parent().add_child(splosion_instance)
	splosion_instance.global_position = _target_last_position
	queue_free()
