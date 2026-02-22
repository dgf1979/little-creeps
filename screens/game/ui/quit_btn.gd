extends Button

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS # prevent button from being included in game pause

func _on_pressed() -> void:
	%QuitConfirmation.popup()
