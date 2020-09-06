extends "res://Source/Scripts/Collections/CollectionCreator.gd"

var last_idx: int

func _ready() -> void:
	collection_name = "POKEMON"
	collection_start = 6
	file_name = "res://Source/Scripts/Collections/PokemonList.gd"
	last_idx = 0

func write_single_icon_path(path: String) -> void:
	content[0] = "const SINGLE_ICON_PATH = " + quoted_str(path)

func write_double_icon_path(path: String) -> void:
	content[1] = "const DOUBLE_ICON_PATH = " + quoted_str(path)

func write_pokemon_line(pokemon_id: int, pokemon_name: String, path: String) -> void:
	var line = "\t" + quoted_str(pokemon_name) + ": {"
	line += quoted_str("id") + ": " + str(pokemon_id) + ", "
	line += quoted_str("path") + ": " + quoted_str(path)
	line += "},"
	last_idx = _find_id_space(str(pokemon_id), "id", last_idx)
	content[last_idx] = line

func _write_resource(file: String) -> void:
	var res = load(base_dir + file)
	var pokemon = res.instance()
	add_child(pokemon)
	pokemon.owner = self
	var path = base_dir
	if path.begins_with("res://"):
		path = path.substr(6, path.length())
	file.erase(file.find("."), 5)
	path += file
	write_pokemon_line(pokemon.national_dex_nr, pokemon.name, path)
	remove_child(pokemon)
	pokemon.free()
