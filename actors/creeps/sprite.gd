extends AnimatedSprite2D

func configure_walk_animation(sprite_sheet: Texture2D, speed: float = 1.0) -> void:
	self.speed_scale = speed
	# set up walk animation frames from atlas texture
	var frames: SpriteFrames = %Sprite.sprite_frames
	if frames.has_animation("walk"): frames.remove_animation("walk")
	frames.add_animation("walk")
	frames.set_animation_loop("walk", true)
	frames.set_animation_speed("walk", 4.0) # Frames per second
	
	@warning_ignore("integer_division") # a sprite sheet is expected to be an exact multiple of the actor size, so I'm ignoring this warning.
	var frame_count = sprite_sheet.get_width() / Constants.MAP_ACTOR_SIZE_PX
	for frame_number in range(frame_count):
		var region = Rect2(frame_number * Constants.MAP_ACTOR_SIZE_PX, 0, Constants.MAP_ACTOR_SIZE_PX, Constants.MAP_ACTOR_SIZE_PX)
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = sprite_sheet
		atlas_texture.region = region
		frames.add_frame("walk", atlas_texture)
		
	play("walk")
