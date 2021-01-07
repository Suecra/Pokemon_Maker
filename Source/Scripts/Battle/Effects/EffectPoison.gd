extends "res://Source/Scripts/Battle/Effects/EffectAilment.gd"

class_name EffectPoison

func _execute(pokemon: Node) -> void:
	pokemon.poison()

func _save_to_json(data: Dictionary) -> void:
	._save_to_json(data)
	data["meta"]["ailment"]["name"] = "poison"
