extends "res://Source/Scripts/Battle/Effect.gd"

const Confusion = preload("res://Source/Scripts/Battle/SecondaryStatus/Confusion.gd")

func _execute(pokemon):
	pokemon.add_secondary_status(Confusion.new())