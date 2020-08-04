extends "res://Source/Scripts/Battle/Status.gd"

func _heal_silent() -> void:
	._heal_silent()
	pokemon.remove_secondary_status(self)
