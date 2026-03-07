extends Sprite2D
class_name Tower

var current_target: Creep = null

func configure(tower_data: TowerData):
	texture = tower_data.load_sprite_base_texture()
	if tower_data.has_turret:
		$Turret.texture = tower_data.load_sprite_turret_texture()
	else: # remove turret node if unused
		$Turret.queue_free()
	$Range.radius = tower_data.target_range
