extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectSleep

func _execute(pokemon: Node) -> void:
	pokemon.sleep()
