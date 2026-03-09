extends Node2D

signal firing()

@onready var tower_data: TowerData = %Config.tower_data

func _ready() -> void:
	match tower_data.type:
		TowerData.Type.WALL: # walls don't shoot, so remove if that's the case
			queue_free()
			return
			
	$Timer.wait_time = tower_data.rate_of_fire
	$Timer.start()
	
func _on_timer_timeout() -> void:
	if (owner as Tower).current_target == null: return
	
	# TODO play firing sound
	print_debug("BANG!")
	
	firing.emit()
