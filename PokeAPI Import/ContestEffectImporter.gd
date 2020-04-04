extends "Importer.gd"

const ContestEffect = preload("res://Source/Data/ContestEffect.gd")

func _create_item():
	return ContestEffect.new()

func _get_name():
	return "contest_effect" + str(api_item["id"])

func _import_item(item):
	item.appeal = api_item["appeal"]
	item.jam = api_item["jam"]
	item.effect = get_en_description(api_item["flavor_text_entries"], "flavor_text")
	yield(get_tree().create_timer(0), "timeout")
