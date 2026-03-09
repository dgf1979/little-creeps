extends AnimatedSprite2D

const IDLE = "idle"
const FIRE = "fire"

@onready var tower_data = (%Config.tower_data as TowerData)
	
func _ready() -> void:
	sprite_frames = SpriteFrames.new()
	sprite_frames.add_animation(IDLE)
	sprite_frames.add_animation(FIRE)
	sprite_frames.set_animation_loop(FIRE, false)
	sprite_frames.set_animation_speed(FIRE, tower_data.projectile_sprite_fps)
	
	var effect_sprite_sheet: Texture2D = tower_data.projectile_sprite_texture
	# expectation here is that sprite sheet is a horizontal strip of exactly square sprites 
	var sheet_height = effect_sprite_sheet.get_height()
	var frame_size = Vector2(sheet_height, sheet_height)
	@warning_ignore("integer_division")
	var frame_count = effect_sprite_sheet.get_width() / sheet_height
	if frame_count < 2: push_error("bullet effect sprite sheet should have at least 2 frames; one for idle and one for firing")
	for i in range(frame_count):
		var frame_pos = Vector2i(i * sheet_height, 0)
		var region = Rect2(frame_pos, frame_size)
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = effect_sprite_sheet
		atlas_texture.region = region
	
		if i == 0: # by convention, first frame is idle (often transparent)
			sprite_frames.add_frame(IDLE, atlas_texture)
		else: #remaining frames are the firing animation that gets played
			sprite_frames.add_frame(FIRE, atlas_texture)
	play(IDLE)
		
func _on_firing_control_firing() -> void:
	play(FIRE)
	
func _on_animation_finished() -> void:
	if animation == FIRE:
		play(IDLE)
