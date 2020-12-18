extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectPoison

func _execute(pokemon: Node) -> void:
	pokemon.poison()
