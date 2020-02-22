extends "res://Source/Scripts/Battle/Observable.gd"

const Nature = preload("res://Source/Data/Nature.gd")
const Utils = preload("res://Source/Scripts/Utils.gd")
const Boosts = preload("res://Source/Scripts/Battle/Boosts.gd")
const BattleAnimationDamage = preload("res://Source/Scripts/Battle/Animations/BattleAnimationDamage.gd")
const BattleAnimationFaint = preload("res://Source/Scripts/Battle/Animations/BattleAnimationFaint.gd")
const BattleAnimationStatus = preload("res://Source/Scripts/Battle/Animations/BattleAnimationStatus.gd")
const CanMoveEventArgs = preload("res://Source/Scripts/Battle/EventArgs/CanMoveEventArgs.gd")
const Movepool = preload("res://Source/Scripts/Battle/Movepool.gd")

enum Gender {Male, Female, Genderless}
enum Stat {ATTACK, DEFENSE, SPECIAL_ATTACK, SPECIAL_DEFENSE, SPEED, ACCURACY, EVASION}

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
var position
var movepool

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

var accuracy_level: float
var evasion_level: float

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

func damage(hp: int, messages = []):
	self.current_hp = current_hp - hp
	var damage_animation = BattleAnimationDamage.new()
	damage_animation.status_bar = status_bar
	damage_animation.damage = hp
	battle.current_turn.register_animation(damage_animation)
	for m in messages:
		battle.register_message(m)
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
	speed = calculate_stat(get_species().speed, speed_ev, speed_iv)
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
	sprite.position = base.calculate_pokemon_position(sprite._get_height())
	return sprite

func burn():
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusBurn.gd").new())

func paralyse():
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusParalysis.gd").new())

func poison():
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusNormalPoison.gd").new())

func badly_poison():
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusBadPoison.gd").new())

func sleep():
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusSleep.gd").new())

func freeze():
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusFreeze.gd").new())

func faint():
	if get_status() == null || get_status().status_name != "Faint":
		change_status(load("res://Source/Scripts/Battle/StatusFaint.gd").new())
		var animation = BattleAnimationFaint.new()
		animation.pokemon = self
		battle.current_turn.register_animation(animation)
		battle.register_message(nickname + " has fainted!")

func change_status_no_override(status) -> bool:
	if has_node("Status"):
		return false
	change_status(status)
	return true

func change_status(status):
	if has_node("Status"):
		$Status._heal_silent()
	status.name = "Status"
	status.pokemon = self
	status.battle = battle
	status.owner = self
	add_child(status)
	var animation_status = BattleAnimationStatus.new()
	animation_status.pokemon = self
	battle.current_turn.register_animation(animation_status)

func remove_primary_status():
	if has_node("Status"):
		remove_child($Status)
		var animation_status = BattleAnimationStatus.new()
		animation_status.pokemon = self
		battle.current_turn.register_animation(animation_status)

func add_secondary_status(status):
	if not $SecondaryStatus.has_node(status.status_name):
		status.name = status.status_name
		status.pokemon = self
		status.battle = battle
		status.owner = self
		$SecondaryStatus.add_child(status)

func remove_secondary_status(status):
	if $SecondaryStatus.has_node(status.status_name):
		$SecondaryStatus.remove_child(status)

func fainted():
	var status = get_status()
	if status != null:
		return status.status_name == "Faint"
	return false

func do_move(move):
	var args = CanMoveEventArgs.new()
	args.move_name = move.move_name
	notify("CAN_MOVE", args)
	if args.can_move:
		move.user = self
		battle.register_message(nickname + " uses " + move.move_name + "!")
		move._execute()

func boost_stat(stat, amount: int):
	match stat:
		Stat.ATTACK: $Boosts.attack_boost += amount
		Stat.DEFENSE: $Boosts.defense_boost += amount
		Stat.SPECIAL_ATTACK: $Boosts.special_attack_boost += amount
		Stat.SPECIAL_DEFENSE: $Boosts.special_defense_boost += amount
		Stat.SPEED: $Boosts.speed_boost += amount
		Stat.ACCURACY: accuracy_level += amount
		Stat.EVASION: evasion_level += amount
	if amount != 0:
		var base_message = nickname + "'s " + get_stat_name(stat)
		if amount > 1:
			battle.register_message(base_message + " rose harshly!")
		elif amount > 0:
			battle.register_message(base_message + " rose!")
		elif amount < -1:
			battle.register_message(base_message + " harshly fell!")
		else:
			battle.register_message(base_message + " fell!")
	$Boosts.boost_stats()
	
func get_stat_name(stat):
	match stat:
		Stat.ATTACK: return "attack"
		Stat.DEFENSE: return "defense"
		Stat.SPECIAL_ATTACK: return "special_attack"
		Stat.SPECIAL_DEFENSE: return "special_defense"
		Stat.SPEED: return "speed"
		Stat.ACCURACY: return "accuracy"
		Stat.EVASION: return "evasion"

func get_last_learnable_moves():
	var moves = []
	var species = get_species()
	if species.has_node("Moves"):
		for m in species.get_node("Moves").get_children():
			if m.level > 0 && m.level <= level:
				var added = false
				for i in moves.size():
					if m.level >= moves[i].level:
						moves.insert(i, m)
						added = true
						break
				if not added && moves.size() < 4:
					moves.append(m)
				if moves.size() > 4:
					moves.remove(4)
	return moves

func get_random_ivs():
	hp_iv = randi() % 31
	attack_iv = randi() % 31
	defense_iv = randi() % 31
	special_attack_iv = randi() % 31
	special_defense_iv = randi() % 31
	speed_iv = randi() % 31 

func begin_of_turn():
	notify("TURN_STARTS")

func end_of_turn():
	notify("TURN_ENDS")

func _ready():
	Utils.add_node_if_not_exists(self, self, "SecondaryStatus")
	Utils.add_node_if_not_exists(self, self, "MoveArchive")
	movepool = Movepool.new()
	movepool.name = "Movepool"
	movepool.owner = self
	movepool.pokemon = self
	add_child(movepool)
	current_hp = hp

func init_battle():
	party = get_parent()
	trainer = party.trainer
	field = trainer.field
	battle = trainer.battle
	battlefield = battle.battlefield
	status_bar = battlefield.get_status_bar(field)
	calculate_stats()
	var boosts = Boosts.new()
	boosts.name = "Boosts"
	boosts.pokemon = self
	boosts.boost_stats()
	add_child(boosts)

func switch_in():
	position = 0
	accuracy_level = 0
	evasion_level = 0
	notify("SWITCH_IN")

func switch_out():
	for status in $SecondaryStatus.get_children():
		status.heal_silent()
	notify("SWITCH_OUT")