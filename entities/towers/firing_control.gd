extends Node2D

var _damage_per_hit: int

signal firing(damage: int)

func configure(tower_data: TowerData) -> void:
	# walls don't shoot, so remove if that's the case
	match tower_data.type:
		TowerData.Type.WALL:
			queue_free()
			return
		TowerData.Type.BULLET:
			%FiringEffect.effect_sprite_sheet = tower_data.projectile_sprite_texture
			%FiringEffect.firing_animation_fps = tower_data.projectile_sprite_fps
			
	_damage_per_hit = tower_data.damage_per_hit
			
	$Timer.autostart = true
	$Timer.wait_time = tower_data.rate_of_fire
	$Timer.timeout.connect(_ready_to_fire)
	
func _ready_to_fire() -> void:
	if (owner as Tower).current_target == null: return
	
	# TODO play firing sound
	print("BANG!")
	
	firing.emit(_damage_per_hit)
		
