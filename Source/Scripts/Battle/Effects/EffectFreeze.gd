extends "res://Source/Scripts/Battle/Effect.gd"

func _execute(pokemon: Node) -> void:
	pokemon.freeze()
