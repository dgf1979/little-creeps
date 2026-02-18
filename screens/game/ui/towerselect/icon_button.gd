extends Button

var _tower_data: TowerData

func setup(tower_data: TowerData) -> void:
	_tower_data = tower_data
	icon = tower_data.load_thumbnail_texture()

func _on_pressed() -> void:
	Event.tower_selected.emit(_tower_data)
