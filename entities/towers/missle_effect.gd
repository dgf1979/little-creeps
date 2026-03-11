extends Sprite2D

@onready var tower_data = (%Config.tower_data as TowerData)

const MISSILE_SCENE: PackedScene = preload("res://entities/towers/missile/missile.tscn")
	
func _ready() -> void:
	# this only applies to missle types, so remove if otherwise
	if tower_data.type != TowerData.Type.MISSILE:
		queue_free()
		return

func _on_firing_control_firing() -> void:
	var missile_instance: Missile = MISSILE_SCENE.instantiate()
	missile_instance.sprite_sheet = tower_data.projectile_sprite_texture
	missile_instance.speed = tower_data.missile_fly_speed
	missile_instance.parent_tower_name = tower_data.display_name
	owner.add_child(missile_instance)
	missile_instance.launch_at((owner as Tower).current_target)
	
