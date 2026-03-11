class_name Splosion
extends Node2D

@export var splosion_texture: Texture2D
@export var blast_radius: int = 99
@export var damage: int = 99

func _ready() -> void:
	$SplosionAnimation.play()
	await get_tree().physics_frame # have to wait for physics to process (needed 2 frames, apparently)
	await get_tree().physics_frame
	var targets: Array[Area2D] = $BlastArea.get_overlapping_areas()
	Event.splode.emit(targets, damage)
	
func _on_splosion_animation_animation_finished() -> void:
	queue_free()
