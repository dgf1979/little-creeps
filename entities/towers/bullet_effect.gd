extends AnimatedSprite2D

const IDLE = "idle"
const FIRE = "fire"

@onready var tower_data = (%Config.tower_data as TowerData)
	
func _ready() -> void:
	# this only applies to bullet types, so remove if otherwise
	if tower_data.type != TowerData.Type.BULLET:
		queue_free()
		return
	
	sprite_frames = SpriteFrames.new()
	sprite_frames.add_animation(IDLE)
	sprite_frames.add_animation(FIRE)
	sprite_frames.set_animation_loop(FIRE, false)
	sprite_frames.set_animation_speed(FIRE, tower_data.projectile_sprite_fps)
	
	var atlas_textures: Array[Texture2D] = Utils.unpack_sprite_sheet(tower_data.projectile_sprite_texture)
	if atlas_textures.size() < 2: push_error("bullet effect sprite sheet should have at least 2 frames; one for idle and one for firing")
	
	# by convention, first frame is idle (often transparent)
	sprite_frames.add_frame(IDLE, atlas_textures[0])
	atlas_textures.remove_at(0)
	#remaining frames are the animation that gets played when missle is in flight
	for atlas_texture in atlas_textures:
		sprite_frames.add_frame(FIRE, atlas_texture)

	play(IDLE)
		
func _on_firing_control_firing() -> void:
	play(FIRE)
	
func _on_animation_finished() -> void:
	if animation == FIRE:
		play(IDLE)
