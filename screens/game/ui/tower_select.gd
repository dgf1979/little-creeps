extends VBoxContainer
class_name TowerSelect

func setup(tower_data: TowerData) -> void:
	%IconButton.icon = tower_data.load_thumbnail_texture()
	%Label.text = tower_data.display_name
