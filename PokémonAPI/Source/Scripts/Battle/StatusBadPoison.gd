extends "res://Source/Scripts/Battle/StatusPoison.gd"

const BASE_DAMAGE = 1.0 / 16.0
var damage

func _ready():
	status_name = "Bad Poison"
	damage = 0

func increase_damage():
	damage = min(damage + BASE_DAMAGE, 15.0 / 16.0)

func _end_of_turn():
	increase_damage()
	register_damage(pokemon.damage_percent(damage))
	if pokemon.fainted():
		register_faint(pokemon)
		battle.register_message(pokemon.nickname + " has fainted!")