extends Node

enum Types {NORMAL, FIGHTING, FLYING, POISON, GROUND, ROCK, BUG, GHOST, STEEL, FIRE, WATER, GRASS, ELECTRIC, PSYCHIC, ICE, DRAGON, DARK, FAIRY, SHADOW, UNKNOWN}

export(Types) var id
export(String) var type_name
export(Types, FLAGS) var very_effective
export(Types, FLAGS) var neutral
export(Types, FLAGS) var not_very_effective
export(Types, FLAGS) var no_effect

func get_damage_multiplier(types: Array) -> float:
	var multiplier = 1.0
	for type in types:
		var flag_id = int(pow(2, type.id))
		if flag_id & very_effective == flag_id:
			multiplier *= 2
		elif flag_id & not_very_effective == flag_id:
			multiplier *= 0.5
		elif flag_id & no_effect == flag_id:
			multiplier *= 0
	return multiplier
