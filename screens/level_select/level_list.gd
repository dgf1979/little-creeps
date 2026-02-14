extends VBoxContainer

const MENU_ITEM: PackedScene = preload("res://screens/level_select/menuitem/menuitem.tscn")

func _ready() -> void:
	#clear placeholders
	for placeholder in get_children():
		placeholder.queue_free()

	var maps_dir = DirAccess.open(Constants.MAPS_PATH)
	if not maps_dir: 
		push_error("Unable to read directory: " + maps_dir)

	var subdirs = maps_dir.get_directories()
	var map_data: Array[MapData] = []
	for dir in subdirs:
		map_data.append(ConfigUtil.load_map_data_for_path(dir))

	for map: MapData in map_data:
		#print_debug(map.map_name + " (" + map.map_dir_name + ")")
		var item_node = MENU_ITEM.instantiate()
		item_node.map_name = map.map_name
		item_node.map_dir_name = map.map_dir_name
		item_node.preview_image = map.load_preview_image()
		add_child(item_node)
