extends Sprite2D
class_name Tower

var current_target: Creep = null

func _ready() -> void:
	Event.tower_instance_select.connect(_on_tower_selected)

func configure(tower_data: TowerData):
	texture = tower_data.load_sprite_base_texture()
	if tower_data.has_turret:
		$Turret.texture = tower_data.load_sprite_turret_texture()
	else: # remove turret node if unused
		$Turret.queue_free()
	$Range.radius = tower_data.target_range


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
