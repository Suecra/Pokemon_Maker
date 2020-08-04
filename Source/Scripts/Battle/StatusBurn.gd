extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

const DAMAGE = 1.0 / 16.0

func _end_of_turn() -> void:
	battle.register_message(pokemon.nickname + " was hurt from it's burn!")
	pokemon.damage_percent(DAMAGE)

func _heal() -> void:
	battle.register_message(pokemon.nickname + " was cured from it's burn!")
	._heal()

func _ready() -> void:
	status_name = "Burn"
	register(pokemon, "TURN_ENDS", "_end_of_turn")
	battle.register_message(pokemon.nickname + " was burned!")
