extends Node

const INC_MULTIPLIER = 1.1
const DEC_MULTIPLIER = 0.9

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

func change_stats(pokemon):
	match inc_stat:
		Stat.Attack: pokemon.attack = int(pokemon.attack * INC_MULTIPLIER)
		Stat.Defense: pokemon.defense = int(pokemon.defense * INC_MULTIPLIER)
		Stat.Special_Attack: pokemon.special_attack = int(pokemon.special_attack * INC_MULTIPLIER)
		Stat.Special_Defense: pokemon.special_defense = int(pokemon.special_defense * INC_MULTIPLIER)
		Stat.Speed: pokemon.speed = int(pokemon.speed * INC_MULTIPLIER)
	match dec_stat:
		Stat.Attack: pokemon.attack = int(pokemon.attack * DEC_MULTIPLIER)
		Stat.Defense: pokemon.defense = int(pokemon.defense * DEC_MULTIPLIER)
		Stat.Special_Attack: pokemon.special_attack = int(pokemon.special_attack * DEC_MULTIPLIER)
		Stat.Special_Defense: pokemon.special_defense = int(pokemon.special_defense * DEC_MULTIPLIER)
		Stat.Speed: pokemon.speed = int(pokemon.speed * DEC_MULTIPLIER)
	pass