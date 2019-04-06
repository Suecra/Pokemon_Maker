extends Node

enum Types {NORMAL, FIGHTING, FLYING, POISON, GROUND, ROCK, BUG, GHOST, STEEL, FIRE, WATER, GRASS, ELECTRIC, PSYCHIC, ICE, DRAGON, DARK, FAIRY, SHADOW, UNKNOWN}

export(Types) var id
export(Types, FLAGS) var very_effective
export(Types, FLAGS) var neutral
export(Types, FLAGS) var not_very_effective
export(Types, FLAGS) var no_effect