extends "res://Source/Scripts/Simulator/ListEdit.gd"

const PokemonList = preload("res://Source/Scripts/Collections/PokemonList.gd")

func _get_items(filter: String):
	return PokemonList.get_pokemon_filter_dict(filter)

func _add_dictionary_item(item, key):
	$List.add_icon_item(PokemonList.get_single_icon(item["id"]), key.capitalize(), item["id"])