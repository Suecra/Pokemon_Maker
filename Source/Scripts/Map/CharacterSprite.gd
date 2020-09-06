extends Node2D

var direction: Vector2 setget _set_direction

func _set_direction(value: Vector2) -> void:
	direction = value

func play_animation(name: String) -> void:
	if _has_animation(name):
		_play_animation(name)

func _has_animation(name: String) -> bool:
	return false

func _play_animation(name: String) -> void:
	pass
