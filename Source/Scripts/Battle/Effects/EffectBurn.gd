extends "res://Source/Scripts/Battle/Effects/EffectAilment.gd"

class_name EffectBurn

func _execute(pokemon: Node) -> void:
	pokemon.burn()

func _save_to_json(data: Dictionary) -> void:
	._save_to_json(data)
	data["meta"]["ailment"]["name"] = "burn"
