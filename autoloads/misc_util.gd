extends Node

# Expectations:
# -sprites sheets are a single sprite high
# -sprites are perfectly square
func unpack_sprite_sheet(sprite_sheet: Texture2D) -> Array[Texture2D]:
	var sheet_height = sprite_sheet.get_height()
	var frame_size = Vector2(sheet_height, sheet_height)
	@warning_ignore("integer_division") # width should be an exact multiple of height
	var frame_count = sprite_sheet.get_width() / sheet_height
	var textures: Array[Texture2D] = []
	for i in range(frame_count):
		var frame_pos = Vector2i(i * sheet_height, 0)
		var region = Rect2(frame_pos, frame_size)
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = sprite_sheet
		atlas_texture.region = region
		textures.append(atlas_texture)
	return textures
