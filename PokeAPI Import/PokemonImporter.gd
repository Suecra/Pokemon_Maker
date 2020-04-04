extends "Importer.gd"

const Pokemon = preload("res://Source/Data/Pokemon.gd")
const PokemonAbility = preload("res://Source/Data/PokemonAbility.gd")
const WildPokemonItem = preload("res://Source/Data/WildPokemonItem.gd")
const LearnableMove = preload("res://Source/Data/LearnableMove.gd")

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

func _import_item(item):
	yield(get_species(api_item["species"]["name"]), "completed")
	var species = result
	item.national_dex_nr = int(species["id"])
	
	item.hp = int(api_item["stats"][5]["base_stat"])
	item.attack = int(api_item["stats"][4]["base_stat"])
	item.defense = int(api_item["stats"][3]["base_stat"])
	item.special_attack = int(api_item["stats"][2]["base_stat"])
	item.special_defense = int(api_item["stats"][1]["base_stat"])
	item.speed = int(api_item["stats"][0]["base_stat"])
	
	item.catch_rate = int(species["capture_rate"])
	item.happiness = int(species["base_happiness"])
	match int(species["gender_rate"]):
		-1: item.gender_chance = get_gender_chance("Genderless") 
		0: item.gender_chance = get_gender_chance("Always-Male")
		1: item.gender_chance = get_gender_chance("Most-Likely-Male")
		2: item.gender_chance = get_gender_chance("Likely-Male") 
		4: item.gender_chance = get_gender_chance("Even-Chance")
		6: item.gender_chance = get_gender_chance("Likely-Female") 
		7: item.gender_chance = get_gender_chance("Most-Likely-Female")
		8: item.gender_chance = get_gender_chance("Always-Female")
	item.egg_cycles = int(species["hatch_counter"])
	item.base_xp = int(api_item["base_experience"])
	item.growth_rate = get_growth_rate(species["growth_rate"]["name"])
	item.category = get_en_description(species["genera"], "genus")
	item.height = api_item["height"]
	item.weight = api_item["weight"]
	item.dex_entry = get_en_description(species["flavor_text_entries"], "flavor_text")
	
	for i in api_item["types"].size():
		add_type(item, api_item["types"][i]["type"]["name"], api_item["types"][i]["slot"])
	for i in api_item["abilities"].size():
		add_ability(item, api_item["abilities"][i]["ability"]["name"], api_item["abilities"][i]["is_hidden"])
	for i in api_item["held_items"].size():
		add_wild_pokemon_item(item, i)
	for i in species["egg_groups"].size():
		add_egg_group(item, species["egg_groups"][i]["name"])
	for i in api_item["moves"].size():
		add_move(item, i)
	

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
	return null
	if !gender_chances.has(name):
		var gender_chance = load("res://Source/Data/Gender-Chance/" + name + ".tscn")
		gender_chances[name] = gender_chance
	return gender_chances[name]

func get_growth_rate(name: String):
	return null
	if !growth_rates.has(name):
		var growth_rate = load("res://Source/Data/Growth-Rate/" + name + ".tscn")
		growth_rates[name] = growth_rate
	return growth_rates[name]

func add_type(item, name: String, slot: int):
	var node = get_or_add_node(item, "Types")
	var type_node
	if node.find_node(name):
		node.remove_child(node.get_node(name))
	var type
	if types.has(name):
		type = types[name]
	else:
		type = load("res://Source/Data/Type/" + name + ".tscn")
		types[name] = type
	type_node = type.instance()
	node.add_child(type_node)
	type_node.owner = item
	node.move_child(type_node, slot - 1)

func add_ability(item, name: String, hidden: bool):
	var node = get_or_add_node(item, "Abilities")
	var ability_node
	if node.find_node(name):
		node.remove_child(node.get_node(name))
	var ability
	if abilities.has(name):
		ability = abilities[name]
	else:
		ability = load("res://Source/Data/Ability/" + name + ".tscn")
		abilities[name] = ability
	ability_node = PokemonAbility.new()
	ability_node.name = name
	ability_node.ability = ability
	ability_node.hidden_ability = hidden
	node.add_child(ability_node)
	ability_node.owner = item

func add_wild_pokemon_item(item, index: int):
	var node = get_or_add_node(item, "Items")
	var name = api_item["held_items"][index]["item"]["name"]
	var item_node = node.get_node(name)
	if item_node != null:
		node.remove_child(item_node)
	var wild_pokemon_item
	if wild_pokemon_items.has(name):
		wild_pokemon_item = wild_pokemon_items[name]
	else:
		if name.find("berry") != -1:
			wild_pokemon_item = load("res://Source/Data/Item/Berry/" + name + ".tscn")
		elif name.find("ball") != -1:
			wild_pokemon_item = load("res://Source/Data/Item/Pokeball/" + name + ".tscn")
		elif name.begins_with("tm") || name.begins_with("hm"):
			wild_pokemon_item = load("res://Source/Data/Item/TM/" + name + ".tscn")
		else:
			wild_pokemon_item = load("res://Source/Data/Item/" + name + ".tscn")
		wild_pokemon_items[name] = wild_pokemon_item
	item_node = WildPokemonItem.new()
	item_node.name = name
	item_node.item = wild_pokemon_item
	item_node.chance = api_item["held_items"][index]["version_details"][0]["rarity"]
	node.add_child(item_node)
	item_node.owner = item

func add_egg_group(item, name: String):
	var node = get_or_add_node(item, "Egg-Groups")
	var egg_group_node
	if node.find_node(name):
		node.remove_child(node.get_node(name))
	var egg_group
	if egg_groups.has(name):
		egg_group = egg_groups[name]
	else:
		egg_group = load("res://Source/Data/Egg-Group/" + name + ".tscn")
		egg_groups[name] = egg_group
	egg_group_node = egg_group.instance()
	node.add_child(egg_group_node)
	egg_group_node.owner = item

func add_move(item, index: int):
	var node = get_or_add_node(item, "Moves")
	var name = api_item["moves"][index]["move"]["name"]
	var move_node
	if node.has_node(name):
		move_node = node.get_node(name)
		#node.remove_child(move_node)
	var level
	var method
	for i in api_item["moves"][index]["version_group_details"].size():
		if api_item["moves"][index]["version_group_details"][i]["version_group"]["name"] == "ultra-sun-ultra-moon":
			level = api_item["moves"][index]["version_group_details"][i]["level_learned_at"]
			method = api_item["moves"][index]["version_group_details"][i]["move_learn_method"]["name"]
			var move
			if moves.has(name):
				move = moves[name]
			else:
				move = load("res://Source/Data/Move/" + name + ".tscn")
				moves[name] = move
			if move_node == null:
				move_node = LearnableMove.new()
				move_node.name = name
				node.add_child(move_node)
				move_node.owner = item
				move_node.move = move
			match method:
				"egg": move_node.egg = true
				"machine": move_node.tm = true
				"level-up": move_node.level = int(level)
