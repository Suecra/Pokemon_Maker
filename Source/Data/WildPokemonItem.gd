extends "res://Source/Data/PMDataObject.gd"

class_name WildPokemonItem

export(PackedScene) var item
export(int) var chance

func _load_from_json(data: Dictionary) -> void:
	name = data["item"]["name"]
	var wild_pokemon_item
	
	if name.find("berry") != -1:
		wild_pokemon_item = load("res://Source/Data/Item/Berry/" + name + ".tscn")
	elif name.find("ball") != -1:
		wild_pokemon_item = load("res://Source/Data/Item/Pokeball/" + name + ".tscn")
	elif name.begins_with("tm") || name.begins_with("hm"):
		wild_pokemon_item = load("res://Source/Data/Item/TM/" + name + ".tscn")
	else:
		wild_pokemon_item = load("res://Source/Data/Item/" + name + ".tscn")
	
	item = wild_pokemon_item
	chance = data["version_details"][0]["rarity"]

func _save_to_json(data: Dictionary) -> void:
	data["item"] = {}
	data["item"]["name"] = name
	data["version_details"] = []
	data["version_details"].append({})
	data["version_details"][0]["rarity"] = chance
