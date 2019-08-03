extends "res://Source/Scripts/Common/PokemonSprite.gd"

func _into_pokeball():
	_hide()
	yield(get_tree().create_timer(0.0), "timeout")

func _out_of_pokeball():
	_show()
	yield(get_tree().create_timer(0.0), "timeout")

func _change_status(status: String):
	if status == "fainted":
		_hide()