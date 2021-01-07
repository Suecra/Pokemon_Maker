extends "res://Source/Scripts/Battle/Effects/EffectAilment.gd"

class_name EffectBadPoison

func _execute(pokemon: Node) -> void:
	pokemon.badly_poison()

func _save_to_json(data: Dictionary) -> void:
	._save_to_json(data)
	data["meta"]["ailment"]["name"] = "poison"
