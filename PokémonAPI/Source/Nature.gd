extends Node

enum Stat {Attack, Defense, Special_Attack, Special_Defense, Speed}
enum Flavor {Spicy, Dry, Sweet, Bitter, Sour}

export(Stat) var inc_stat
export(Stat) var dec_stat
export(Flavor) var likes_flavor
export(Flavor) var hates_flavor

export(int, 1, 100) var high_hp_attack_chance
export(int, 1, 100) var low_hp_attack_chance

export(int, 1, 100) var high_hp_defense_chance
export(int, 1, 100) var low_hp_defense_chance

export(int, 1, 100) var high_hp_support_chance
export(int, 1, 100) var low_hp_support_chance