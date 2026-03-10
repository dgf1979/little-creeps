extends Sprite2D

@onready var tower_data = (%Config.tower_data as TowerData)

const MISSILE_SCENE: PackedScene = preload("res://entities/towers/missile/missile.tscn")
	
func _ready() -> void:
	# this only applies to missle types, so remove if otherwise
	if tower_data.type != TowerData.Type.MISSILE:
		queue_free()
		return

func _on_firing_control_firing() -> void:
	var missle_instance: Missile = MISSILE_SCENE.instantiate()
	missle_instance.sprite_sheet = tower_data.projectile_sprite_texture
	add_child(missle_instance)
	missle_instance.launch_at((owner as Tower).current_target)
	
