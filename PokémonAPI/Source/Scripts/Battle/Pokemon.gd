extends Node

const Nature = preload("res://Source/Data/Nature.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")

enum Gender {Male, Female, Genderless}

export(String) var nickname
export(int, 1, 100) var level
export(Gender) var gender
export(int) var current_hp setget set_current_hp
export(PackedScene) var species
export(PackedScene) var nature

var item
var party
var trainer
var field
var battle
var battlefield
var encounter
var status_bar

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
	current_hp = max(current_hp, 0)

func damage(hp: int):
	self.current_hp = current_hp - hp
	print(nickname + " took " + str(hp) + " HP Damage")
	if current_hp == 0:
		faint()

func calculate_stats():
	calculate_hp()
	attack = calculate_stat(get_species().attack, attack_ev, attack_iv)
	defense = calculate_stat(get_species().defense, defense_ev, defense_iv)
	special_attack = calculate_stat(get_species().special_attack, special_attack_ev, special_attack_iv)
	special_defense = calculate_stat(get_species().special_defense, special_defense_ev, special_defense_iv)
	speed = calculate_stat(get_species().speed, defense_ev, defense_iv)
	get_nature().change_stats(self)

func calculate_stat(base: int, ev: int, iv: int):
	return floor((2 * base + iv + ev / 4) * level / 100 + 5)

func calculate_hp():
	hp = floor(((2 * get_species().hp + hp_iv + hp_ev / 4) * level / 100) + level + 10)

func get_status():
	if has_node("Status"):
		return $Status
	return null

func get_movepool():
	if has_node("Movepool"):
		return $Movepool
	return null

func get_types():
	return get_species().get_node("Types").get_children()

func get_species():
	return Utils.unpack(self, species, "Species")

func get_nature():
	return Utils.unpack(self, nature, "Nature")

func faint():
	print(nickname + " has fainted!")
	var status = load("res://Source/Scripts/Battle/StatusFainted.gd").new()
	status.owner = self
	status.name = "Status"
	add_child(status)

func fainted():
	var status = get_status()
	if status != null:
		return status._pokemon_fainted()
	return false

func can_move():
	var status = get_status()
	if status != null:
		return status._can_move()
	return true

func _ready():
	Utils.add_node_if_not_exists(self, self, "SecondaryStatus")
	Utils.add_node_if_not_exists(self, self, "MoveArchive")
	calculate_stats()
	current_hp = hp

func init_battle():
	party = get_parent()
	trainer = party.trainer
	field = trainer.field
	battle = trainer.battle
	battlefield = battle.battlefield
