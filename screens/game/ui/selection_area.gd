extends Control

func _ready() -> void:
	var towers = (%LevelData.tower_data as Dictionary[String, TowerData])
	for count in range(8):
		var i = count + 1
		var texture_button: TextureButton = $TowerGrid.get_node("Tower" + str(i))
		var margin_container: MarginContainer = $TowerLabelGrid.get_node("MarginContainer" + str(i)) 
		var label: Label = margin_container.get_node("Panel/Tower" + str(i) + "Lbl")
		if count < towers.keys().size():
			var tower_name = towers.keys()[count]
			var tower_data = towers[tower_name]
			texture_button.texture_normal = tower_data.load_thumbnail_texture()
			label.text = tower_data.display_name
		else:
			texture_button.hide()
			margin_container.hide()

		
