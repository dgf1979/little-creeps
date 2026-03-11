extends AnimatedSprite2D

@onready var missile: Missile = owner

const IDLE = "idle"
const FLYING = "flying"
func _ready() -> void:
	sprite_frames = SpriteFrames.new()
	sprite_frames.add_animation(IDLE)
	sprite_frames.add_animation(FLYING)
	sprite_frames.set_animation_loop(FLYING, true)
	sprite_frames.set_animation_speed(FLYING, 24.0) #TODO make this configurable
	
	var atlas_textures: Array[Texture2D] = Utils.unpack_sprite_sheet(missile.sprite_sheet)
	if atlas_textures.size() < 2: push_error("missle effect sprite sheet should have at least 2 frames; one for idle and one (or more) for flying/firing")
	
	# by convention, first frame is idle (often transparent)
	sprite_frames.add_frame(IDLE, atlas_textures[0])
	atlas_textures.remove_at(0)
	#remaining frames are the animation that gets played when missle is in flight
	for atlas_texture in atlas_textures:
		sprite_frames.add_frame(FLYING, atlas_texture)
		
	play(IDLE)
	
func fly() -> void:
	play(FLYING)
