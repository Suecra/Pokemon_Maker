extends Node

var direction

func play_animation(name: String):
	if _has_animation(name):
		play_animation(name)

func _has_animation(name: String):
	return false

func _play_animation(name: String):
	pass
