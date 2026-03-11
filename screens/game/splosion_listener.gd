extends Node

func _ready() -> void:
	Event.splode.connect(_sploded)
	
func _sploded(targets: Array[Area2D], damage: int) -> void:
	for area in targets:
		if area.owner.is_in_group(Constants.CREEP_GROUP):
			(area.owner as Creep).take_damage(damage)
