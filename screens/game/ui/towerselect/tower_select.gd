extends VBoxContainer
class_name TowerSelect

func setup(tower_data: TowerData) -> void:
	%IconButton.setup(tower_data)
	%Label.text = tower_data.display_name
