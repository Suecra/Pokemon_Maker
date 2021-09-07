extends "res://Source/Data/PMDataObject.gd"

class_name Pokemon

export(String) var pokemon_name
export(int) var regional_dex_nr
export(int) var national_dex_nr

export(int) var hp
export(int) var attack
export(int) var defense
export(int) var special_attack
export(int) var special_defense
export(int) var speed

export(int) var catch_rate
export(int) var happiness

export(int) var egg_cycles
export(int) var base_xp
export(String) var category = ""
export(float) var height
export(float) var weight
export(PackedScene) var color
export(PackedScene) var shape

export(String, MULTILINE) var dex_entry

export(PackedScene) var sprite_collection

onready var gender_chance := $GenderChance
onready var growth_rate := $GrowthRate

func _init(name: String = "") -> void:
	if name != "":
		load_from_file(Consts.POKEMON_PATH + name + ".json")

func get_sprite_collection() -> Node:
	if not has_node("Sprites"):
		var sprites_name = String(national_dex_nr)
		while sprites_name.length() < 4:
			sprites_name = "0" + sprites_name
		var res = load(Consts.SPRITE_COLLECTION_PATH + sprites_name + ".tscn")
		var sprites
		if res != null:
			sprites = res.instance()
		else:
			sprites = SpriteCollection.new()
		sprites.name = "Sprites"
		add_child(sprites)
		sprites.owner = self
	return $Sprites

func _load_from_json(data: Dictionary) -> void:
	var species = data["species"]
	national_dex_nr = int(species["id"])
	pokemon_name = data["name"]
	name = pokemon_name
	
	hp = int(data["stats"][0]["base_stat"])
	attack = int(data["stats"][1]["base_stat"])
	defense = int(data["stats"][2]["base_stat"])
	special_attack = int(data["stats"][3]["base_stat"])
	special_defense = int(data["stats"][4]["base_stat"])
	speed = int(data["stats"][5]["base_stat"])
	
	catch_rate = int(species["capture_rate"])
	happiness = int(species["base_happiness"])
	
	match int(species["gender_rate"]):
		-1: gender_chance = load_gender_chance("Genderless")
		0: gender_chance = load_gender_chance("Always_Male")
		1: gender_chance = load_gender_chance("Most_Likely_Male")
		2: gender_chance = load_gender_chance("Likely_Male")
		4: gender_chance = load_gender_chance("Even_Chance")
		6: gender_chance = load_gender_chance("Likely_Female")
		7: gender_chance = load_gender_chance("Most_Likely_Female")
		8: gender_chance = load_gender_chance("Always_Female")
	
	egg_cycles = int(species["hatch_counter"])
	base_xp = int(data["base_experience"])
	var type = load("res://Source/Data/Growth-Rate/" + species["growth_rate"]["name"] + ".gd")
	growth_rate = Utils.add_typed_node_if_not_exists(type, self, self, "GrowthRate")
	category = get_en_description(species["genera"], "genus")
	height = data["height"]
	weight = data["weight"]
	dex_entry = get_en_description(species["flavor_text_entries"], "flavor_text")
	
	for i in data["types"].size():
		add_type(data["types"][i]["type"]["name"], data["types"][i]["slot"])
	for i in data["abilities"].size():
		add_ability(data["abilities"][i])
	for i in data["held_items"].size():
		add_wild_pokemon_item(data["held_items"][i])
	for i in species["egg_groups"].size():
		add_egg_group(species["egg_groups"][i]["name"])
	for i in data["moves"].size():
		add_move(data["moves"][i])

func _save_to_json(data: Dictionary) -> void:
	data["species"] = {}
	var species = data["species"]
	species["id"] = national_dex_nr
	if pokemon_name == "":
		pokemon_name = name.capitalize()
	data["name"] = pokemon_name
	
	data["stats"] = [{}, {}, {}, {}, {}, {}]
	data["stats"][5]["base_stat"] = hp
	data["stats"][4]["base_stat"] = attack
	data["stats"][3]["base_stat"] = defense
	data["stats"][2]["base_stat"] = special_attack
	data["stats"][1]["base_stat"] = special_defense
	data["stats"][0]["base_stat"] = speed
	
	species["capture_rate"] = catch_rate
	species["base_happiness"] = happiness
	
	gender_chance._save_to_json(species)
	
	species["hatch_counter"] = egg_cycles
	data["base_experience"] = base_xp
	species["growth_rate"] = {}
	growth_rate._save_to_json(species["growth_rate"])
	species["genera"] = []
	set_en_description(species["genera"], "genus", category)
	data["height"] = height
	data["weight"] = weight
	species["flavor_text_entries"] = []
	set_en_description(species["flavor_text_entries"], "flavor_text", dex_entry)
	
	data["types"] = []
	if has_node("Types"):
		for i in $Types.get_child_count():
			data["types"].append({})
			data["types"][i]["type"] = {}
			data["types"][i]["type"]["name"] = $Types.get_child(i).name
			data["types"][i]["slot"] = i + 1
	data["abilities"] = []
	if has_node("Abilities"):
		for i in $Abilities.get_child_count():
			data["abilities"].append({})
			$Abilities.get_child(i)._save_to_json(data["abilities"][i])
	data["held_items"] = []
	if has_node("Items"):
		for i in $Items.get_child_count():
			data["held_items"].append({})
			$Items.get_child(i)._save_to_json(data["held_items"][i])
	species["egg_groups"] = []
	if has_node("Egg-Groups"):
		for i in $"Egg-Groups".get_child_count():
			species["egg_groups"].append({})
			species["egg_groups"][i]["name"] = $"Egg-Groups".get_child(i).name
	data["moves"] = []
	if has_node("Moves"):
		for i in $Moves.get_child_count():
			data["moves"].append({})
			$Moves.get_child(i)._save_to_json(data["moves"][i])

func add_type(name: String, slot: int) -> void:
	var node = Utils.add_node_if_not_exists(self, self, "Types")
	var type_node
	type_node = load("res://Source/Data/Type/" + name + ".tscn").instance()
	node.add_child(type_node)
	type_node.owner = self
	node.move_child(type_node, slot - 1)

func add_ability(data: Dictionary) -> void:
	var node = Utils.add_node_if_not_exists(self, self, "Abilities")
	var ability_node
	ability_node = PokemonAbility.new()
	ability_node._load_from_json(data)
	node.add_child(ability_node)
	ability_node.owner = self

func add_wild_pokemon_item(data: Dictionary) -> void:
	var node = Utils.add_node_if_not_exists(self, self, "Items")
	var name = data["item"]["name"]
	var item_node = node.get_node(name)
	if item_node != null:
		node.remove_child(item_node)

	item_node = WildPokemonItem.new()
	item_node._load_from_json(data)
	node.add_child(item_node)
	item_node.owner = self

func add_egg_group(name: String) -> void:
	var node = Utils.add_node_if_not_exists(self, self, "Egg-Groups")
	var egg_group_node
	if node.find_node(name):
		node.remove_child(node.get_node(name))
	egg_group_node = load("res://Source/Data/Egg-Group/" + name + ".tscn").instance()
	node.add_child(egg_group_node)
	egg_group_node.owner = self

func add_move(data: Dictionary) -> void:
	var node = Utils.add_node_if_not_exists(self, self, "Moves")
	var move_node = LearnableMove.new()
	move_node._load_from_json(data)
	node.add_child(move_node)
	move_node.owner = self

func load_gender_chance(name: String) -> Node:
	return Utils.add_typed_node_if_not_exists(load("res://Source/Data/Gender-Chance/" + name + ".gd"), self, self, "GenderChance")
