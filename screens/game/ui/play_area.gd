extends TextureRect

func _ready() -> void:
	texture = (%LevelData as LevelData).map_data.load_map_image()
