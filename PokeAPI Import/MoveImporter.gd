extends "Importer.gd"

var contest_effects = []
var moves = []
var api_items = []

func _create_item():
	return Move.new()

func _load():
	item = _create_item()

func _save():
	item.save_to_file(path) 

func _import_item():
	item._load_from_json(api_item)
	yield(get_tree().create_timer(0), "timeout")
