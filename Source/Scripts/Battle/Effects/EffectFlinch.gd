extends "res://Source/Scripts/Battle/Effect.gd"

class_name EffectFlinch

const Flinch = preload("res://Source/Scripts/Battle/SecondaryStatus/Flinch.gd")

func _execute(pokemon: Node) -> void:
	pokemon.add_secondary_status(Flinch.new())
