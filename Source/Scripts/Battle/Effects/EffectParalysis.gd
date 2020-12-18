extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectParalysis

func _execute(pokemon: Node) -> void:
	pokemon.paralyse()
