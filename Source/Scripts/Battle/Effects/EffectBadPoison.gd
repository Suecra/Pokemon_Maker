extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectBadPoison

func _execute(pokemon: Node) -> void:
	pokemon.badly_poison()
