extends "res://Source/Scripts/Battle/BattleObject.gd"

const Nature = preload("res://Source/Data/Nature.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")

enum Gender {Male, Female, Genderless}

export(PackedScene) var species
export(String) var nickname
export(int, 1, 100) var level
export(Gender) var gender
export(int) var current_hp setget set_current_hp

var hp: int = 100
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

export(PackedScene) var nature
export(PackedScene) var item

export(bool) var shiny

func set_current_hp(value: int):
	current_hp = min(value, hp)

func _init():
	Utils.add_node_if_not_exists(self, self, "Status")
	Utils.add_node_if_not_exists(self, self, "SecondaryStatus")
	Utils.add_node_if_not_exists(self, self, "Moves")
	Utils.add_node_if_not_exists(self, self, "MoveArchive")
