extends ConfirmationDialog

func _on_canceled() -> void:
	self.hide()
	get_tree().paused = false

func _on_confirmed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://screens/start/start.tscn")

func _on_about_to_popup() -> void:
	get_tree().paused = true
