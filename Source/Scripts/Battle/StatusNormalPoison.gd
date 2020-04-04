extends "res://Source/Scripts/Battle/StatusPoison.gd"

const DAMAGE = 1.0 / 8.0

func _end_of_turn():
	battle.register_message(pokemon.nickname + " was hurt from it's poison!")
	pokemon.damage_percent(DAMAGE)

func _ready():
	status_name = "Poison"
	register(pokemon, "TURN_ENDS", "_end_of_turn")
	battle.register_message(pokemon.nickname + " was poisoned!")