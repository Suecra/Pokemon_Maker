extends "res://Source/Scripts/Battle/Effects/EffectAilment.gd"

class_name EffectConfusion

const Confusion = preload("res://Source/Scripts/Battle/SecondaryStatus/Confusion.gd")

func _execute(pokemon: Node) -> void:
	pokemon.add_secondary_status(Confusion.new())

func _save_to_json(data: Dictionary) -> void:
	._save_to_json(data)
	data["meta"]["ailment"]["name"] = "confusion"
