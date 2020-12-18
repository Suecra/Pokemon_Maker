extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectBurn

func _execute(pokemon: Node) -> void:
	pokemon.burn()
