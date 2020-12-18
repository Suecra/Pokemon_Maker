extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectFreeze

func _execute(pokemon: Node) -> void:
	pokemon.freeze()
