extends Node
# signals are used elsewhere, not in the bus itself
# warnings cannot be excluded per-file, so must annotate each new signal
# (warning-ignore-all is proposed but not implemented as of Godot 4.6)
@warning_ignore("unused_signal")
signal tower_selected(tower_data: TowerData)
@warning_ignore("unused_signal")
signal tower_placed(tower_data: TowerData)
@warning_ignore("unused_signal")
signal tower_select_cancelled()
