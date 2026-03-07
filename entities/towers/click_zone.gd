extends TextureButton

func _on_focus_entered() -> void:
	$Range.show()
	
func _on_focus_exited() -> void:
	$Range.hide()
