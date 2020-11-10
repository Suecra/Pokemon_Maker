extends Node

func _load_from_json(data: Dictionary) -> void:
	pass

func _save_to_json(data: Dictionary) -> void:
	pass

func load_from_file(filename: String) -> void:
	var file = File.new()
	var result = file.open(filename, 1)
	if result == 0:
		var json = parse_json(file.get_as_text())
		if json != null:
			_load_from_json(json)
		file.close()

func save_to_file(filename: String) -> void:
	var file = File.new()
	var result = file.open(filename, 2)
	if result == 0:
		var json: Dictionary
		_save_to_json(json)
		file.store_line(to_json(json))
		file.close()

func get_en_description(entries: Array, property_name: String) -> String:
	for i in entries.size():
		if entries[i]["language"]["name"] == "en":
			return entries[i][property_name]
	return ""

func set_en_description(entries: Array, property_name: String, description: String) -> void:
	entries.append({})
	entries[0]["language"] = {}
	entries[0]["language"]["name"] = "en"
	entries[0][property_name] = description
