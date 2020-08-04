extends Node

enum Types {NORMAL, FIGHTING, FLYING, POISON, GROUND, ROCK, BUG, GHOST, STEEL, FIRE, WATER, GRASS, ELECTRIC, PSYCHIC, ICE, DRAGON, DARK, FAIRY, SHADOW, UNKNOWN}

signal selected

export(String) var move_name setget _set_move_name
export(int) var type_id setget _set_type_id
export(int) var max_pp setget _set_max_pp
export(int) var pp setget _set_pp

var move_id: int

func _set_move_name(value: String):
	pass

func _set_type_id(value: int):
	pass

func _set_max_pp(value: int):
	pass

func _set_pp(value: int):
	pass
