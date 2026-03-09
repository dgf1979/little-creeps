extends TextureRect

func _ready() -> void:
	texture = (%LevelData as LevelData).map_data.map_image
