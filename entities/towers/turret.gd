extends Sprite2D

@onready var tower: Tower = owner

func _ready() -> void:
	if %Config.tower_data.has_turret:
		texture = %Config.tower_data.sprite_turret_texture
	else: # remove this node if unused
		queue_free()

func _process(_delta: float) -> void:
	if tower.current_target != null:
		look_at(tower.current_target.global_position)
