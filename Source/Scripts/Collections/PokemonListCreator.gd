extends "res://Source/Scripts/Collections/CollectionCreator.gd"

const PokemonList = preload("res://Source/Scripts/Collections/PokemonList.gd")

var list: PokemonList

func _ready() -> void:
	list = PokemonList.new()

func _write_resource(file: String) -> void:
	var res = load(base_dir + file)
	var pokemon = res.instance()
	add_child(pokemon)
	pokemon.owner = self
	list.add(pokemon.pokemon_name, pokemon.national_dex_nr)
	remove_child(pokemon)
	pokemon.free()

func save_collection() -> void:
	list.save_list()
