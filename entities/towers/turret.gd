extends Sprite2D

@onready var tower = get_parent()

func _process(delta: float) -> void:
	if tower.current_target != null:
		look_at(tower.current_target)
