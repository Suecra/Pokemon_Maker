extends "res://Source/Scripts/Collections/CollectionCreator.gd"

var last_idx: int

func _ready():
	collection_name = 'POKEMON'
	collection_start = 6
	file_name = "res://Source/Scripts/Collections/PokemonList.gd"
	last_idx = 0

func quoted_str(value):
	return "\"" + str(value) + "\""

func write_single_icon_path(path: String):
	content[0] = "const SINGLE_ICON_PATH = " + quoted_str(path)

func write_double_icon_path(path: String):
	content[1] = "const DOUBLE_ICON_PATH = " + quoted_str(path)

func write_pokemon_line(pokemon_id: int, pokemon_name: String, path: String, last: bool = false):
	var line = "\t" + quoted_str(pokemon_name) + ": {"
	line += quoted_str("id") + ": " + str(pokemon_id) + ", "
	line += quoted_str("path") + ": " + quoted_str(path)
	line += "}"
	if not last:
		line += ","
	last_idx = _find_id_space(pokemon_id, last_idx)
	content[last_idx] = line

func _write_resource(file: String):
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

func _find_id_space(id: int, start_idx: int = collection_start - 1):
	start_idx = max(start_idx, collection_start - 1)
	var i = start_idx
	while i < content.size():
		var position = content[i].find(quoted_str("id") + ":")
		if position == -1:
			content.insert(i, "")
			return i
		var a_id = content[i].substr(position + 6, content[i].find(",", position + 6)).to_int()
		if a_id == id:
			return i
		if a_id > id:
			content.insert(i, "")
			return i
		i += 1
	return start_idx