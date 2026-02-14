extends Node

func append(path: String, path_to_append: String) -> String:
	path = path.rstrip("/").rstrip("\\")
	path_to_append.lstrip("/".lstrip("\\"))
	return path + "/" + path_to_append
