extends "res://Source/Scripts/Battle/Effects/EffectAilment.gd"

class_name EffectFreeze

func _execute(pokemon: Node) -> void:
	pokemon.freeze()

func _save_to_json(data: Dictionary) -> void:
	._save_to_json(data)
	data["meta"]["ailment"]["name"] = "freeze"
