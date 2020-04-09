extends Node2D

var direction setget _set_direction

func _set_direction(value):
	direction = value

func play_animation(name: String):
	if _has_animation(name):
		_play_animation(name)

func _has_animation(name: String):
	return false

func _play_animation(name: String):
	pass
