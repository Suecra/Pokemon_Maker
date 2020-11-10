extends "Importer.gd"

var species_list = []
var gender_chances: Dictionary
var growth_rates: Dictionary
var types: Dictionary
var abilities: Dictionary
var wild_pokemon_items: Dictionary
var egg_groups: Dictionary
var moves: Dictionary

func _create_item():
	return Pokemon.new()

func _load():
	item = _create_item()
	#item.load_from_file(path)

func _save():
	item.save_to_file(path)

func _import_item():
	yield(get_species(api_item["species"]["name"]), "completed")
	var species = result
	api_item["species"] = species
	item._load_from_json(api_item)

func get_species(name):
	for spec in species_list:
		if spec["name"] == name:
			result = spec
			yield(get_tree().create_timer(0), "timeout")
			return
	yield(do_request(api_item["species"]["url"], true), "completed")
	result = json.result
	species_list.append(result)
