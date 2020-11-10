extends "res://Source/Data/PMDataObject.gd"

class_name PokemonAbility

export(PackedScene) var ability
export(bool) var hidden_ability

func _load_from_json(data: Dictionary) -> void:
	name = data["ability"]["name"]
	ability = load("res://Source/Data/Ability/" + name + ".tscn")
	hidden_ability = data["is_hidden"]

func _save_to_json(data: Dictionary) -> void:
	data["ability"] = {}
	data["ability"]["name"] = name
	data["is_hidden"] = hidden_ability
