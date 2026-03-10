class_name Splosion
extends Node2D

func _ready() -> void:
	$SplosionAnimation.play()
	Event.splode.emit($BlastArea)

func _on_splosion_animation_animation_finished() -> void:
	queue_free()
