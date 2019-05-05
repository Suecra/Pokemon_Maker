extends "Importer.gd"

const Pokemon = preload("res://Source/Pokemon.gd")
const PokemonAbility = preload("res://Source/PokemonAbility.gd")

var species_list = []
var gender_chances: Dictionary
var growth_rates: Dictionary
var types: Dictionary
var abilities: Dictionary

func _create_item():
	return Pokemon.new()

func _import_item(item):
	yield(get_species(api_item["species"]["name"]), "completed")
	var species = result
	item.national_dex_nr = species["pokedex_numbers"][species["pokedex_numbers"].size() - 1]["entry_number"]
	
	item.hp = api_item["stats"][5]["base_stat"]
	item.attack = api_item["stats"][4]["base_stat"]
	item.defense = api_item["stats"][3]["base_stat"]
	item.special_attack = api_item["stats"][2]["base_stat"]
	item.special_defense = api_item["stats"][1]["base_stat"]
	item.speed = api_item["stats"][0]["base_stat"]
	
	item.catch_rate = species["capture_rate"]
	item.happiness = species["base_happiness"]
	match int(species["gender_rate"]):
		-1: item.gender_chance = get_gender_chance("Genderless") 
		0: item.gender_chance = get_gender_chance("Always-Male")
		1: item.gender_chance = get_gender_chance("Most-Likely-Male")
		2: item.gender_chance = get_gender_chance("Likely-Male") 
		4: item.gender_chance = get_gender_chance("Even-Chance")
		6: item.gender_chance = get_gender_chance("Likely-Female") 
		7: item.gender_chance = get_gender_chance("Most-Likely-Female")
		8: item.gender_chance = get_gender_chance("Always-Female")
	item.egg_cycles = species["hatch_counter"]
	item.base_xp = api_item["base_experience"]
	item.growth_rate = get_growth_rate(species["growth_rate"]["name"])
	item.category = get_en_description(species["genera"], "genus")
	item.height = api_item["height"]
	item.weight = api_item["weight"]
	item.dex_entry = get_en_description(species["flavor_text_entries"], "flavor_text")
	
	for i in api_item["types"].size():
		add_type(item, api_item["types"][i]["type"]["name"], api_item["types"][i]["slot"])
	
	for i in api_item["abilities"].size():
		add_ability(item, api_item["abilities"][i]["ability"]["name"], api_item["abilities"][i]["is_hidden"])

func get_species(name):
	for spec in species_list:
		if spec["name"] == name:
			result = spec
			yield(get_tree().create_timer(0), "timeout")
			return
	yield(do_request(api_item["species"]["url"], true), "completed")
	result = json.result
	species_list.append(result)

func get_gender_chance(name: String):
	if !gender_chances.has(name):
		var gender_chance = load("res://Source/Gender-Chance/" + name + ".tscn")
		gender_chances[name] = gender_chance
	return gender_chances[name]

func get_growth_rate(name: String):
	if !growth_rates.has(name):
		var growth_rate = load("res://Source/Growth-Rate/" + name + ".tscn")
		growth_rates[name] = growth_rate
	return growth_rates[name]

func add_type(item, name: String, slot: int):
	var node = item.get_node("Types")
	if node == null:
		node = Node.new()
		node.name = "Types"
		item.add_child(node)
		node.owner = item
	var type_node = node.get_node(name)
	if type_node != null:
		node.remove_child(type_node)
	var type
	if types.has(name):
		type = types[name]
	else:
		type = load("res://Source/Type/" + name + ".tscn")
		types[name] = type
	type_node = type.instance()
	node.add_child(type_node)
	type_node.owner = item
	node.move_child(type_node, slot - 1)

func add_ability(item, name: String, hidden: bool):
	var node = item.get_node("Abilities")
	if node == null:
		node = Node.new()
		node.name = "Abilities"
		item.add_child(node)
		node.owner = item
	var ability_node = node.get_node(name)
	if ability_node != null:
		node.remove_child(ability_node)
	var ability
	if abilities.has(name):
		ability = abilities[name]
	else:
		ability = load("res://Source/Ability/" + name + ".tscn")
		abilities[name] = ability
	ability_node = PokemonAbility.new()
	ability_node.name = name
	ability_node.ability = ability
	ability_node.hidden_ability = hidden
	node.add_child(ability_node)
	ability_node.owner = item
