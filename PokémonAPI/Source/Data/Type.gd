extends Node

enum Types {NORMAL, FIGHTING, FLYING, POISON, GROUND, ROCK, BUG, GHOST, STEEL, FIRE, WATER, GRASS, ELECTRIC, PSYCHIC, ICE, DRAGON, DARK, FAIRY, SHADOW, UNKNOWN}

export(Types) var id
export(Types, FLAGS) var very_effective
export(Types, FLAGS) var neutral
export(Types, FLAGS) var not_very_effective
export(Types, FLAGS) var no_effect

func get_damage_multiplier(types):
	var multiplier = 1.0
	for type in types:
		if type.id & very_effective == type.id:
			multiplier *= 2
		elif type.id & not_very_effective == type.id:
			multiplier *= 0.5
		elif type.id & no_effect == type.id:
			multiplier *= 0
	return multiplier