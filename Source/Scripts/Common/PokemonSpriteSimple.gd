extends "res://Source/Scripts/Common/PokemonSprite.gd"

func _into_pokeball() -> void:
	_hide()
	yield(get_tree().create_timer(0.0), "timeout")

func _out_of_pokeball() -> void:
	_show()
	yield(get_tree().create_timer(0.0), "timeout")

func _change_status(status: String) -> void:
	if status == "fainted":
		_hide()

func _faint() -> void:
	_hide()
	yield(get_tree().create_timer(0.0), "timeout")
