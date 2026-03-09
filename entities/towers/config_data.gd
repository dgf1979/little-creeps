class_name Config
extends Node

# this exists simply as a place to access the tower config data and any relevant helper methods.
# it could be shared directly from the root scene node, but that happens to be the only node that
# cannot be set to be accessible via a unique name via '%', and I didn't want to use 'owner' due
# to the loss of automatic type hint.

var tower_data: TowerData

func store(_tower_data: TowerData) -> void:
	self.tower_data = _tower_data
	
func is_wall() -> bool:
	return tower_data.type == TowerData.Type.WALL
	
