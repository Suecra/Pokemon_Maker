extends "res://Source/Scripts/Battle/StatusPoison.gd"

const BASE_DAMAGE = 1.0 / 16.0
var damage

func _ready():
	status_name = "Bad Poison"
	register(pokemon, "TURN_ENDS", "_end_of_turn")
	battle.register_message(pokemon.nickname + " was badly poisoned!")
	damage = 0

func increase_damage():
	damage = min(damage + BASE_DAMAGE, 15.0 / 16.0)

func _end_of_turn():
	increase_damage()
	battle.register_message(pokemon.nickname + " was hurt from it's poision!")
	register_damage(pokemon.damage_percent(damage))

func _switch_in():
	damage = 0