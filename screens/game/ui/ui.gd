extends Control

@onready var is_release_build = OS.has_feature("release")
@onready var debug_modal: PopupPanel = %DebugPanel

func _input(event: InputEvent) -> void:
	if is_release_build: return
	if event.is_action_released("Toggle Debug Modal"):
		#modal is responsible for closing itself
		debug_modal.open()			
		get_viewport().set_input_as_handled()
