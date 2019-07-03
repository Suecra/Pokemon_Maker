extends Node

const Nature = preload("res://Source/Data/Nature.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")

enum Gender {Male, Female, Genderless}

export(String) var nickname
export(int, 1, 100) var level
export(Gender) var gender
export(int) var current_hp setget set_current_hp

var species
var nature: Nature
var item
var party
var trainer
var field
var battle
var encounter

var hp: int
var attack: int
var defense: int
var special_attack: int
var special_defense: int
var speed: int

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

export(bool) var shiny

func set_current_hp(value: int):
	current_hp = min(value, hp)

func calculate_stats():
	calculate_hp()
	attack = calculate_stat(species.attack, attack_ev, attack_iv)
	defense = calculate_stat(species.defense, defense_ev, defense_iv)
	special_attack = calculate_stat(species.special_attack, special_attack_ev, special_attack_iv)
	special_defense = calculate_stat(species.special_defense, special_defense_ev, special_defense_iv)
	speed = calculate_stat(species.speed, defense_ev, defense_iv)
	nature.change_stats(self)

func calculate_stat(base: int, ev: int, iv: int):
	return floor((2 * base + iv + ev / 4) * level / 100 + 5)

func calculate_hp():
	hp = floor((2 * species.hp + hp_iv + hp_ev / 4) * level / 100 + level + 10)

func get_status():
	if has_node("Status"):
		return $Status
	return null

func get_movepool():
	if has_node("Movepool"):
		return $Movepool
	return null

func get_types():
	return species.get_node("Types").get_children()

func fainted():
	var status = get_status()
	if status != null:
		return status._pokemon_fainted()
	return false

func _ready():
	Utils.add_node_if_not_exists(self, self, "SecondaryStatus")
	Utils.add_node_if_not_exists(self, self, "MoveArchive")
