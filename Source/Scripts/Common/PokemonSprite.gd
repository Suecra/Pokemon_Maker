extends Node2D

class_name PokemonSprite

func _show() -> void:
	visible = true

func _hide() -> void:
	visible = false

func _change_status(status: String) -> void:
	pass

func _into_pokeball() -> void:
	yield(get_tree().create_timer(0.0), "timeout")

func _out_of_pokeball() -> void:
	yield(get_tree().create_timer(0.0), "timeout")

func _faint() -> void:
	yield(get_tree().create_timer(0.0), "timeout")

func _get_height() -> float:
	return 0.0
