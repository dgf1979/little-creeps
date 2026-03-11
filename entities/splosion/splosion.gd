class_name Splosion
extends Node2D

func _ready() -> void:
	$SplosionAnimation.play()
	await get_tree().physics_frame # have to wait for physics to process (needed 2 frames, apparently)
	await get_tree().physics_frame
	var targets: Array[Area2D] = $BlastArea.get_overlapping_areas()
	Event.splode.emit(targets, 11)
	
	
func _on_splosion_animation_animation_finished() -> void:
	queue_free()
