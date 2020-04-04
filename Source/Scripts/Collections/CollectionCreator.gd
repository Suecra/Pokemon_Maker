extends Node

var collection_start: int
var collection_name: String
var file_name: String
var base_dir: String
var content = []

func read_file():
	var file = File.new()
	file.open(file_name, 1)
	content.clear()
	var line = file.get_line()
	while not file.eof_reached():
		content.append(line)
		line = file.get_line()
	file.close()

func write_file():
	var file = File.new()
	file.open(file_name, 2)
	for line in content:
		file.store_line(line)
	file.close()

func create_collection():
	read_file()
	
func save_collection():
	write_file()

func quoted_str(value):
	return "\"" + str(value) + "\""

func _find_id_space(id, id_name: String, start_idx: int = collection_start):
	start_idx = max(start_idx, collection_start - 1)
	var i = start_idx
	while i < content.size():
		var position = content[i].find(quoted_str(id_name) + ":")
		if position == -1:
			content.insert(i, "")
			return i
		var offset = id_name.length() + 4
		var a_id = content[i].substr(position + offset, content[i].find(",", position + offset))
		if a_id == str(id):
			return i
		if a_id > str(id):
			content.insert(i, "")
			return i
		i += 1
	return start_idx

func _write_resource(file: String):
	pass

func create_from_directory(path: String):
	base_dir = path
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)
	var file = dir.get_next()
	while file != "":
		_write_resource(file)
		file = dir.get_next()
	pass