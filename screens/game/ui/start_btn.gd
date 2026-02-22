extends Button

const start_text = "Start"
const pause_text = "Pause"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS # prevent button from bewing included in game pause
	text = start_text

func _pressed() -> void:
	if text == start_text:
		Event.game_start.emit()
		get_tree().paused = false
		text = pause_text
	else:
		Event.game_pause.emit()
		get_tree().paused = true
		text = start_text
