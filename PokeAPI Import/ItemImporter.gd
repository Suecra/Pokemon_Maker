extends "Importer.gd"

const Item = preload("res://Source/Data/Item.gd")
const Ball = preload("res://Source/Data/Ball.gd")
const TM = preload("res://Source/Data/TM.gd")
const Berry = preload("res://Source/Data/Berry.gd")

var pocket
var categories = []

func _get_path(directory_name, name):
	yield(get_category(api_item["category"]["name"]), "completed")
	pocket = result["pocket"]["name"]
	var sub_folder_name = ""
	if pocket == "pokeballs":
		sub_folder_name = "Pokeball"
	elif pocket == "berries":
		sub_folder_name = "Berry"
	elif pocket == "machines":
		sub_folder_name = "TM"
	if sub_folder_name != "":
		directory_name += "/" + sub_folder_name
		if !directory.dir_exists(directory_name):
			directory.make_dir(directory_name)
	result = directory_name + "/" + name + ".tscn"

func _create_item():
	if pocket == "pokeballs":
		return Ball.new()
	elif pocket == "berries":
		return Berry.new()
	elif pocket == "machines":
		return TM.new()
	else:
		return Item.new()
	pass

func _import_item(item):
	match pocket:
		"misc": item.pocket = Item.Pocket.Objects
		"medicine": item.pocket = Item.Pocket.Medicine
		"pokeballs": item.pocket = Item.Pocket.Balls
		"machines": item.pocket = Item.Pocket.TMs
		"berries": item.pocket = Item.Pocket.Berries
		"mail": item.pocket = Item.Pocket.Letters
		"battle": item.pocket = Item.Pocket.Battle_Items
		"key": item.pocket = Item.Pocket.Key_Items
	yield(get_category(api_item["category"]["name"]), "completed")
	item.category = result["names"][0]["name"]
	item.price = api_item["cost"]
	item.sell_price = item.price / 2
	var attributes = get_attributes()
	if attributes.find("countable"):
		item.stack_size = 999
	else:
		item.stack_size = 1
	item.holdable = attributes.find("holdable") != -1
	item.fling_power = api_item["fling_power"]
	item.description = get_en_description(api_item["flavor_text_entries"], "text")

func get_attributes():
	var ret = []
	for i in api_item["attributes"].size():
		ret.append(api_item["attributes"][i]["name"])
	return ret

func get_category(name):
	for cat in categories:
		if cat["name"] == name:
			result = cat
			yield(get_tree().create_timer(0), "timeout")
			return
	yield(do_request(api_item["category"]["url"], true), "completed")
	result = json.result
	categories.append(result)