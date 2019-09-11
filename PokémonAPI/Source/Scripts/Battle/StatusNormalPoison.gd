extends "res://Source/Scripts/Battle/StatusPoison.gd"

const DAMAGE = 1 / 8

func _end_of_turn():
	register_damage(pokemon.damage_percent(DAMAGE))
	if pokemon.fainted():
		register_faint(pokemon)
		battle.register_message(pokemon.nickname + " has fainted!")

func _ready():
	status_name = "Poision"