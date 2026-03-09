extends Button

var _tower_data: TowerData

func setup(tower_data: TowerData) -> void:
	_tower_data = tower_data
	icon = tower_data.thumbnail_texture
	disabled = true
	Event.game_start.connect(_on_game_start)

func _on_pressed() -> void:
	Event.tower_select.emit(_tower_data)
	
func _on_game_start() -> void:
	disabled = false
