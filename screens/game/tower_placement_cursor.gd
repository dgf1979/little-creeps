extends ColorRect
class_name TowerPacementCursor

const _alpha = 0.6
const _block_color = Color(Color.RED, _alpha)
const _valid_color = Color(Color.GREEN, _alpha)

var _selected_tower_data: TowerData
var _can_place_tower: bool = false

func _ready() -> void:
	Event.tower_select.connect(_on_tower_select)
	hide()
	
func can_place_tower(tf: bool) -> void:
	_can_place_tower = tf
	if _can_place_tower:
		color = _valid_color
	else:
		color = _block_color

func _on_tower_select(tower_data: TowerData) -> void:
	_selected_tower_data = tower_data
	print(_selected_tower_data.display_name.to_upper())
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	$Icon.texture = tower_data.load_thumbnail_texture()
	$Range.radius = tower_data.target_range
	show()

func _process(_delta: float) -> void:
	if visible:
		%ActiveMap.cursor_snap_to_map(self)
		
func _input(event: InputEvent) -> void:
	# only process input here when a tower has been selected
	if _selected_tower_data == null: 
		return
	
	if (event.is_action_pressed("right_mouse_click")):
		_deselect_tower()
		return
	
	if (event.is_action_pressed("left_mouse_click")):
		if _can_place_tower:
			Event.tower_place.emit(_selected_tower_data)
			_deselect_tower()
		
func _deselect_tower() -> void:
	_selected_tower_data = null
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
