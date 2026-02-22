extends Node

@onready var timer: Timer = $WaveTimer
@onready var waves: Array[WaveData] = %LevelData.wave_data
var _current_wave = 0

func _ready() -> void:
	#Signals
	Event.game_start.connect(_on_game_start)

var previous_seconds_remaining = 0
func _process(delta: float) -> void:
	var seconds_remaining: int = floor(timer.time_left)
	if seconds_remaining < previous_seconds_remaining: Event.wave_countdown_tick.emit(seconds_remaining)
	previous_seconds_remaining = seconds_remaining

func _on_game_start() -> void:
	timer.wait_time = 10
	timer.start()
	
func _on_wave_timer_timeout() -> void:
	pass # Replace with function body.
