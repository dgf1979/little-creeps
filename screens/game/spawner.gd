extends Node

const SPLOSION: PackedScene = preload("res://entities/splosion/splosion.tscn") 

func _ready() -> void:
	Event.spawn_splosion.connect(_spawn_splosion)
	
func _spawn_splosion(tower_name: String, global_position: Vector2) -> void:
	var tower_data: TowerData = (%LevelData as LevelData).tower_data.get(tower_name)
	
	var splosion_instance: Splosion = SPLOSION.instantiate()
	splosion_instance.global_position = global_position
	splosion_instance.blast_radius = tower_data.missile_explosion_blast_radius
	splosion_instance.damage = tower_data.damage_per_hit
	splosion_instance.splosion_texture = tower_data.missile_explosion_sprite_texture
	splosion_instance.animation_speed = tower_data.missile_explosion_sprite_animation_fps
	add_child(splosion_instance)
	
