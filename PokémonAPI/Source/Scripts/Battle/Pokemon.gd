extends Node

const Nature = preload("res://Source/Data/Nature.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")
const Boosts = preload("res://Source/Scripts/Battle/Boosts.gd")

enum Gender {Male, Female, Genderless}
enum Stat {ATTACK, DEFENSE, SPECIAL_ATTACK, SPECIAL_DEFENSE, SPEED}

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

var current_attack: int
var current_defense: int
var current_special_attack: int
var current_special_defense: int
var current_speed: int

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
	if current_hp == 0:
		faint()

func damage_percent(percent: float):
	var damage = int(hp * percent)
	damage(damage)
	return damage

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

func get_sprite():
	var sprite
	var base
	if field == battle.ally_field:
		base = battle.get_node("BasePlayer")
		base.remove_child(base.get_node("PKMNSprite"))
		if shiny:
			sprite = Utils.unpack(base, get_species().get_sprite_collection().shiny_back_sprite, "PKMNSprite")
		else:
			sprite = Utils.unpack(base, get_species().get_sprite_collection().back_sprite, "PKMNSprite")
	elif field == battle.opponent_field:
		base = battle.get_node("BaseOpponent")
		base.remove_child(base.get_node("PKMNSprite"))
		if shiny:
			sprite = Utils.unpack(base, get_species().get_sprite_collection().shiny_sprite, "PKMNSprite")
		else:
			sprite = Utils.unpack(base, get_species().get_sprite_collection().front_sprite, "PKMNSprite")
	sprite.position = base.pokemon_position
	return sprite

func burn():
	change_status(load("res://Source/Scripts/Battle/StatusBurn.gd").new())

func paralyse():
	change_status(load("res://Source/Scripts/Battle/StatusParalysis.gd").new())

func poison():
	change_status(load("res://Source/Scripts/Battle/StatusNormalPoison.gd").new())

func badly_poison():
	change_status(load("res://Source/Scripts/Battle/StatusBadPoison.gd").new())

func sleep():
	change_status(load("res://Source/Scripts/Battle/StatusSleep.gd").new())

func freeze():
	change_status(load("res://Source/Scripts/Battle/StatusFreeze.gd").new())

func faint():
	change_status(load("res://Source/Scripts/Battle/StatusFaint.gd").new())

func change_status(status):
	if has_node("Status"):
		remove_child($Status)
	status.name = "Status"
	status.pokemon = self
	status.battle = battle
	status.owner = self
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

func boost_stat(stat, amount: int):
	match stat:
		Stat.ATTACK: $Boosts.attack_boost += amount
		Stat.DEFENSE: $Boosts.defense_boost += amount
		Stat.SPECIAL_ATTACK: $Boosts.special_attack_boost += amount
		Stat.SPECIAL_DEFENSE: $Boosts.special_defense_boost += amount
		Stat.SPEED: $Boosts.speed_boost += amount
	$Boosts.boost_stats()

func get_last_learnable_moves():
	var moves = []
	var last_added_move
	var species = get_species()
	if species.has_node("Moves"):
		for m in species.get_node("Moves").get_children():
			if not m.egg && not m.tm && m.level <= level:
				if last_added_move != null || m.level >= last_added_move.level:
					moves.insert(0, m.move)
					last_added_move = m
	return moves

func begin_of_turn():
	var status = get_status()
	if status != null:
		status._begin_of_turn()

func end_of_turn():
	var status = get_status()
	if status != null:
		status._end_of_turn()

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
	status_bar = battlefield.get_status_bar(field)
	var boosts = Boosts.new()
	boosts.name = "Boosts"
	boosts.pokemon = self
	boosts.boost_stats()
	add_child(boosts)
