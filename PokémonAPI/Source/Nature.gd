extends Node

enum Stat {Attack, Defense, Special Attack, Special Defense, Speed}
enum Flavor {Spicy, Dry, Sweet, Bitter, Sour}

export(Stat) var inc_stat
export(Stat) var dec_stat
export(Flavor) var likes_flavor
export(Flavor) var hates_flavor