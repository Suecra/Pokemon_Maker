extends "res://Source/Scripts/Battle/Status.gd"

func _pokemon_fainted():
	return true

func _can_move():
	return false

func _ready():
	status_name = "Faint"