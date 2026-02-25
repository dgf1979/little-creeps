extends TextureButton
class_name Tower

func configure(tower_data: TowerData):
	#TODO load correct textures
	texture_normal = tower_data.load_thumbnail_texture()
