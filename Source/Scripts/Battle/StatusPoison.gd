extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

func _heal() -> void:
	battle.register_message(pokemon.nickname + " was cured from it's poison!")
	._heal()
