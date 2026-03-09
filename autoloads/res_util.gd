extends Node

func load_texture_resource(img_path: String) -> Texture2D:
	var resource = ResourceLoader.load(img_path)
	if resource == null:
		push_error("failed to load image: " + img_path)
	return resource
	
func load_audio_resource(file_path: String) -> AudioStream:
	var resource = ResourceLoader.load(file_path)
	if resource == null:
		push_error("failed to load audio from: " + file_path)
	return resource
	
func load_texture_resource_as_image(img_path: String) -> Image:
	var texture: Texture2D = load_texture_resource(img_path)
	var image: Image = texture.get_image()
	if image.is_compressed():
		image.decompress()
	return image
