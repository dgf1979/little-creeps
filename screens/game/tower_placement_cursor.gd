extends ColorRect
class_name TowerPacementCursor

const _blocked = Color.RED
const _valid = Color.GREEN
const _alpha = 0.7

func _ready() -> void:
	Event.tower_selected.connect(_on_tower_selected)
	Event.tower_placed.connect(_on_tower_placed)
	Event.tower_select_cancelled.connect(_on_tower_select_cancelled)
	hide()

func _on_tower_selected(_tower_data) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	color = _blocked
	color.a = _alpha
	show()
	
func _on_tower_select_cancelled() -> void:
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _on_tower_placed(_tower_data) -> void:
	_on_tower_select_cancelled()

func _process(_delta: float) -> void:
	if visible:
		%ActiveMap.cursor_snap_to_map(self)
	
func _input(event: InputEvent) -> void:
	if  (event is InputEventMouseButton 
	and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT 
	and (event as InputEventMouseButton).pressed):
		Event.tower_select_cancelled.emit()
