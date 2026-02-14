extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%DebugMap.show()
	else:
		%DebugMap.hide()
