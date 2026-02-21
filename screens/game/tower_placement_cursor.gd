extends ColorRect
class_name TowerPacementCursor

const _alpha = 0.6
const _block_color = Color(Color.RED, _alpha)
const _valid_color = Color(Color.GREEN, _alpha)

var _selected_tower_data: TowerData

func _ready() -> void:
	Event.tower_select.connect(_on_tower_select)
	Event.tower_place.connect(_on_tower_place)
	Event.tower_select_cancel.connect(_on_tower_select_cancel)
	hide()
	
func can_place_tower(tf: bool) -> void:
	if tf:
		color = _valid_color
	else:
		color = _block_color

func _on_tower_select(tower_data: TowerData) -> void:
	_selected_tower_data = tower_data
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$Icon.texture = tower_data.load_thumbnail_texture()
	show()
	
func _on_tower_select_cancel() -> void:
	_selected_tower_data = null
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _on_tower_place(_tower_data) -> void:
	_on_tower_select_cancel()

func _process(_delta: float) -> void:
	if visible:
		%ActiveMap.cursor_snap_to_map(self)
		
func _input(event: InputEvent) -> void:
	if  (event.is_action_pressed("left_mouse_click")):
		pass # TODO
		#Event.tower_place.emit(_selected_tower_data)
