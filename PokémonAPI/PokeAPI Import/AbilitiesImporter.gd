extends "Importer.gd"

const Ability = preload("res://Source/Ability.gd")

func _create_item():
	return Ability.new()

func _import_item(item):
	item.description = get_en_description(json.result["flavor_text_entries"])

func get_en_description(entries):
	for i in entries.size() - 1:
		if entries[i]["language"]["name"] == "en":
			return entries[i]["flavor_text"]
		pass
	return ""