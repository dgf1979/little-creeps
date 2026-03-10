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
	
	var effect_sprite_sheet: Texture2D = missile.sprite_sheet
	# expectation here is that sprite sheet is a horizontal strip of exactly square sprites 
	var sheet_height = effect_sprite_sheet.get_height()
	var frame_size = Vector2(sheet_height, sheet_height)
	@warning_ignore("integer_division")
	var frame_count = effect_sprite_sheet.get_width() / sheet_height
	if frame_count < 2: push_error("missile effect sprite sheet should have at least 2 frames; one for idle and one or more while traveling")
	for i in range(frame_count):
		var frame_pos = Vector2i(i * sheet_height, 0)
		var region = Rect2(frame_pos, frame_size)
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = effect_sprite_sheet
		atlas_texture.region = region
	
		if i == 0: # by convention, first frame is idle (often transparent)
			sprite_frames.add_frame(IDLE, atlas_texture)
		else: #remaining frames are the firing animation that gets played
			sprite_frames.add_frame(FLYING, atlas_texture)
	play(IDLE)
	
func fly() -> void:
	play(FLYING)
