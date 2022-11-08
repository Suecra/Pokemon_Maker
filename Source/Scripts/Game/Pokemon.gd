extends Node

export(String) var nickname
export(String) var species
export(int, 1, 100) var level
export(Consts.Gender) var gender
export(int) var current_hp setget set_current_hp
export(String) var nature
export(String) var item

export(int, 0, 252) var hp_ev
export(int, 0, 252) var attack_ev
export(int, 0, 252) var defense_ev
export(int, 0, 252) var special_attack_ev
export(int, 0, 252) var special_defense_ev
export(int, 0, 252) var speed_ev

export(int, 0, 31) var hp_iv
export(int, 0, 31) var attack_iv
export(int, 0, 31) var defense_iv
export(int, 0, 31) var special_attack_iv
export(int, 0, 31) var special_defense_iv
export(int, 0, 31) var speed_iv

export(int, 0, 255) var happiness
export(bool) var shiny

var pokemon: Reference
var hp: int
var attack: int
var defense: int
var special_attack: int
var special_defense: int
var speed: int

func get_hp() -> int:
	return int(floor(((2 * pokemon.hp + hp_iv + hp_ev / 4) * level / 100)) + level + 10)

func get_attack() -> int:
	return int(calculate_stat(pokemon.attack, attack_ev, attack_iv, 0))

func get_defense() -> int:
	return int(calculate_stat(pokemon.defense, defense_ev, defense_iv, 1))

func get_special_attack() -> int:
	return int(calculate_stat(pokemon.special_attack, special_attack_ev, special_attack_iv, 2))

func get_special_defense() -> int:
	return int(calculate_stat(pokemon.special_defense, special_defense_ev, special_defense_iv, 3))

func get_speed() -> int:
	return int(calculate_stat(pokemon.speed, speed_ev, speed_iv, 4))

func set_current_hp(value: int) -> void:
	current_hp = min(value, hp)
	current_hp = max(current_hp, 0)

func calculate_stat(base: int, ev: int, iv: int, idx: int) -> float:
	return floor(floor((2 * base + iv + ev / 4) * level / 100 + 5) * Consts.NATURE_STAT_BOOST[nature][idx])

func get_moves() -> Array:
	var moves = []
	find_moves(self, moves)
	return moves

func find_moves(node: Node, moves: Array) -> void:
	for child in node.get_children():
		if child.get_meta("class_name") == "Move":
			moves.append(child)
			find_moves(child, moves)
