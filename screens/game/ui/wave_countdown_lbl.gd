extends Label

const _text = "Seconds to next wave: "

func _ready() -> void:
	Event.wave_countdown_tick.connect(_update)
	
func _update(seconds_remaining: int) -> void:
	text = _text + str(seconds_remaining)
