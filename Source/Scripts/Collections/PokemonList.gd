extends Reference

const SINGLE_ICON_PATH = "res://Graphics/Icons/single/"
const DOUBLE_ICON_PATH = "res://Graphics/Icons/animated/"
const ICON_NAME_DIGITS = 3
const PokemonListFileName = "res://Source/Data/PokemonList.json"

var pokemon_list: Dictionary

func get_pokemon_filter_dict(filter: String) -> Dictionary:
	var result = {}
	filter = filter.to_lower()
	for key in pokemon_list.keys():
		if key.to_lower().begins_with(filter.to_lower()):
			result[key] = pokemon_list[key]
	return result

static func get_single_icon(pokemon_id: int) -> Resource:
	var filename = str(pokemon_id)
	while filename.length() < ICON_NAME_DIGITS:
		filename = "0" + filename
	filename += ".png"
	filename = SINGLE_ICON_PATH + filename
	return load(filename)

func save_to_file(file: File) -> void:
	pokemon_list["nidoranfe"] = 29
	pokemon_list["nidoranma"] = 32
	file.store_string(to_json(pokemon_list))

func load_from_file(file: File) -> void:
	pokemon_list = parse_json(file.get_as_text())

func save_list() -> void:
	var file = File.new()
	file.open(PokemonListFileName, File.WRITE)
	save_to_file(file)
	file.close()

func load_list() -> void:
	var file = File.new()
	file.open(PokemonListFileName, File.READ)
	load_from_file(file)
	file.close()

func get_pokemon_file_path(name: String) -> String:
	return Consts.POKEMON_PATH + name + ".json"

func add(name: String, id: int) -> void:
	var a_name = name.replace("-", "")
	pokemon_list[name] = id
	pokemon_list[a_name] = id
