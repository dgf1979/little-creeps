extends Sprite2D
class_name Tower

@onready var creep_detection: Area2D = $CreepDetection

var current_target: Creep = null
var is_wall: bool = false

func _ready() -> void:
	Event.tower_instance_select.connect(_on_tower_selected)

func configure(tower_data: TowerData):
	texture = tower_data.sprite_base_texture
	is_wall = tower_data.type == TowerData.Type.WALL
	$Turret.configure(tower_data)
	$Range.configure(tower_data)
	$CreepDetection.configure(tower_data)


func _on_click_zone_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Event.tower_instance_select.emit(self)
		$Range.show()
	else:
		Event.tower_instance_deselect.emit(self)
		$Range.hide()
		
func _on_tower_selected(tower: Tower) -> void:
	# only one tower instance should be selected at a time, so toggle this off if another has been selected
	if tower != self:
		$ClickZone.button_pressed = false
	
		
func _process(_delta: float) -> void:
	# walls don't need to do anything
	if is_wall: return
	# don't need to look for creeps in range if we already have a current target
	if current_target != null: return
	
	# otherwise target the first creep in range 
	for area in creep_detection.get_overlapping_areas():
		if area.owner.is_in_group("creeps"):
			current_target = area.owner
			return

func _on_creep_detection_area_entered(area: Area2D) -> void:
	# don't care about new creeps in our area if we already have a target
	if current_target != null: return
	# otherwise, set this creep current target
	if area.owner.is_in_group("creeps"):
		current_target = area.owner

func _on_creep_detection_area_exited(area: Area2D) -> void:
	# if our current target leaves our area, remove it as current target
	if area.owner == current_target:
		current_target = null
