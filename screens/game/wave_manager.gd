extends Node

@onready var timer: Timer = $WaveTimer
@onready var waves: Array[WaveData] = %LevelData.wave_data
var _current_wave_idx: int = -1

func _start_next_wave() -> void:
	_current_wave_idx += 1
	if _current_wave_idx == waves.size(): return
	var wave = waves[_current_wave_idx]
	if _current_wave_idx + 1 < waves.size():
		timer.wait_time = wave.duration
		timer.start()
	%CreepFactory.spawn(wave.creep_name, wave.count)

func _ready() -> void:
	#Signals
	Event.game_start.connect(_on_game_start)

var previous_seconds_remaining = 0
func _process(_delta: float) -> void:
	var seconds_remaining: int = floor(timer.time_left)
	if seconds_remaining < previous_seconds_remaining: Event.wave_countdown_tick.emit(seconds_remaining)
	previous_seconds_remaining = seconds_remaining

func _on_game_start() -> void:
	if _current_wave_idx < 0: _start_next_wave()
	
func _on_wave_timer_timeout() -> void:
	_start_next_wave()
