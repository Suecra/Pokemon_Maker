extends "res://Source/Scripts/Battle/StatusPoison.gd"

const BASE_DAMAGE = 1.0 / 16.0
var damage

func _ready() -> void:
	status_name = "Bad Poison"
	register(pokemon, "TURN_ENDS", "end_of_turn")
	register(pokemon, "SWITCH_IN", "switch_in")
	battle.register_message(pokemon.nickname + " was badly poisoned!")
	damage = 0

func increase_damage() -> void:
	damage = min(damage + BASE_DAMAGE, 15.0 / 16.0)

func end_of_turn() -> void:
	increase_damage()
	battle.register_message(pokemon.nickname + " was hurt from it's poison!")
	pokemon.damage_percent(damage)

func switch_in() -> void:
	damage = 0
