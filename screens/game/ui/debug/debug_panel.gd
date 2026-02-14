extends PopupPanel

func _input(event: InputEvent) -> void:
	if (event.is_action_released("Toggle Debug Modal")): 
		get_viewport().set_input_as_handled()
		self.close()

func open() -> void:
	get_tree().paused = true
	self.popup()

func close() -> void:
	self.hide()
	get_tree().paused = false
