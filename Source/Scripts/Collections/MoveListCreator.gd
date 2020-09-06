extends "res://Source/Scripts/Collections/CollectionCreator.gd"

var last_idx: int

func _ready() -> void:
	collection_name = "MOVE"
	collection_start = 2
	file_name = "res://Source/Scripts/Collections/MoveList.gd"
	last_idx = 0

func _write_resource(file: String) -> void:
	var res = load(base_dir + file)
	var move = res.instance()
	add_child(move)
	move.owner = self
	var path = base_dir
	if path.begins_with("res://"):
		path = path.substr(6, path.length())
	file.erase(file.find("."), 5)
	path += file
	write_move_line(move.name, path)
	remove_child(move)
	move.free()

func write_move_line(move_name: String, path: String) -> void:
	var line = "\t" + quoted_str(move_name) + ": {"
	line += quoted_str("name") + ": " + quoted_str(move_name) + ", "
	line += quoted_str("path") + ": " + quoted_str(path)
	line += "},"
	last_idx = _find_id_space(move_name, "name", last_idx)
	content[last_idx] = line
