extends "res://Source/Scripts/Battle/Effects/EffectAilment.gd"

class_name EffectParalysis

func _execute(pokemon: Node) -> void:
	pokemon.paralyse()

func _save_to_json(data: Dictionary) -> void:
	._save_to_json(data)
	data["meta"]["ailment"]["name"] = "paralysis"
