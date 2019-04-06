extends "Importer.gd"

const Ability = preload("res://Source/Ability.gd")

func _create_item():
	return Ability.new()

func _import_item(item):
	item.description = get_en_description(api_item["flavor_text_entries"], "flavor_text")
	yield(get_tree().create_timer(0), "timeout")