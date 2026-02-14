extends Button

@export var preview_image: Texture
@export var map_name: String
@export var map_dir_name: String

func _ready() -> void:
	%MapNameLbl.text = map_name
	%MapPreview.texture = preview_image
	
func _on_pressed() -> void:
	Selection.selected_map_dir = map_dir_name
	get_tree().change_scene_to_file("res://screens/game/game.tscn")
