extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectFlinch

const Flinch = preload("res://Source/Scripts/Battle/SecondaryStatus/Flinch.gd")

func _execute(pokemon: Node) -> void:
	pokemon.add_secondary_status(Flinch.new())

func _save_to_json(data: Dictionary) -> void:
	._save_to_json(data)
	data["meta"]["flinch_chance"] = int(chance * 100)
