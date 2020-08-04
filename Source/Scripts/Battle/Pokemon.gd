extends "res://Source/Scripts/Battle/Observable.gd"

const Nature = preload("res://Source/Data/Nature.gd")
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
export(PackedScene) var species setget set_species
export(PackedScene) var nature setget set_nature

var item: Node
var field: Node
var battle: Node
var battlefield: Node
var status_bar: Node
var position: int

onready var primary_status := $Status
onready var movepool := $Movepool
var secondary_status: Node
var boosts: Node

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

func set_species(value: PackedScene) -> void:
	species = value
	if has_node("Species"):
		remove_child($Species)

func set_nature(value: PackedScene) -> void:
	nature = value
	if has_node("Nature"):
		remove_child($Nature)

func set_current_hp(value: int) -> void:
	current_hp = min(value, hp)
	current_hp = max(current_hp, 0)

func damage(hp: int, messages = []) -> void:
	self.current_hp = current_hp - hp
	var damage_animation = BattleAnimationDamage.new()
	damage_animation.status_bar = status_bar
	damage_animation.damage = hp
	battle.current_turn.register_animation(damage_animation)
	for message in messages:
		battle.register_message(message)
	if current_hp == 0:
		faint()

func damage_percent(percent: float) -> int:
	var damage = int(hp * percent)
	damage(damage)
	return damage

func full_heal() -> void:
	current_hp = hp
	heal_primary_status(true)
	if movepool != null:
		for move in movepool.get_children():
			move.restore_pp()

func calculate_stats() -> void:
	calculate_hp()
	attack = calculate_stat(get_species().attack, attack_ev, attack_iv)
	defense = calculate_stat(get_species().defense, defense_ev, defense_iv)
	special_attack = calculate_stat(get_species().special_attack, special_attack_ev, special_attack_iv)
	special_defense = calculate_stat(get_species().special_defense, special_defense_ev, special_defense_iv)
	speed = calculate_stat(get_species().speed, speed_ev, speed_iv)
	get_nature().change_stats(self)

func calculate_stat(base: int, ev: int, iv: int) -> float:
	return floor((2 * base + iv + ev / 4) * level / 100 + 5)

func calculate_hp() -> void:
	hp = floor(((2 * get_species().hp + hp_iv + hp_ev / 4) * level / 100) + level + 10)

func get_types():
	return get_species().get_node("Types").get_children()

func get_species() -> Node:
	return Utils.unpack(self, species, "Species")

func get_nature() -> Node:
	return Utils.unpack(self, nature, "Nature")

func get_sprite() -> Node:
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

func burn() -> bool:
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusBurn.gd").new())

func paralyse() -> bool:
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusParalysis.gd").new())

func poison() -> bool:
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusNormalPoison.gd").new())

func badly_poison() -> bool:
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusBadPoison.gd").new())

func sleep() -> bool:
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusSleep.gd").new())

func freeze() -> bool:
	return change_status_no_override(load("res://Source/Scripts/Battle/StatusFreeze.gd").new())

func faint():
	if primary_status == null || primary_status.status_name != "Faint":
		change_status(load("res://Source/Scripts/Battle/StatusFaint.gd").new())
		var animation = BattleAnimationFaint.new()
		animation.pokemon = self
		battle.current_turn.register_animation(animation)
		battle.register_message(nickname + " has fainted!")

func change_status_no_override(status: Node) -> bool:
	if has_node("Status"):
		return false
	change_status(status)
	return true

func change_status(status: Node) -> void:
	heal_primary_status(true)
	status.name = "Status"
	status.pokemon = self
	status.battle = battle
	add_child(status)
	status.owner = self
	primary_status = status
	var animation_status = BattleAnimationStatus.new()
	animation_status.pokemon = self
	battle.current_turn.register_animation(animation_status)

func remove_primary_status() -> void:
	if primary_status != null:
		remove_child(primary_status)
		var animation_status = BattleAnimationStatus.new()
		animation_status.pokemon = self
		battle.current_turn.register_animation(animation_status)

func heal_primary_status(silent: bool) -> void:
	if primary_status != null:
		if silent:
			primary_status._heal_silent()
		else:
			primary_status._heal()

func add_secondary_status(status: Node) -> void:
	if secondary_status.has_node(status.status_name):
		status.name = status.status_name
		status.pokemon = self
		status.battle = battle
		status.owner = self
		secondary_status.add_child(status)

func remove_secondary_status(status: Node) -> void:
	if secondary_status.has_node(status.status_name):
		secondary_status.remove_child(status)

func fainted() -> bool:
	if primary_status != null:
		return primary_status.status_name == "Faint"
	return false

func do_move(move: Node) -> void:
	var args = CanMoveEventArgs.new()
	args.move_name = move.move_name
	notify("CAN_MOVE", args)
	if args.can_move:
		move.user = self
		battle.register_message(nickname + " uses " + move.move_name + "!")
		move._execute()

func boost_stat(stat, amount: int) -> void:
	match stat:
		Stat.ATTACK: boosts.attack_boost += amount
		Stat.DEFENSE: boosts.defense_boost += amount
		Stat.SPECIAL_ATTACK: boosts.special_attack_boost += amount
		Stat.SPECIAL_DEFENSE: boosts.special_defense_boost += amount
		Stat.SPEED: boosts.speed_boost += amount
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
	boosts.boost_stats()
	
func get_stat_name(stat) -> String:
	match stat:
		Stat.ATTACK: return "attack"
		Stat.DEFENSE: return "defense"
		Stat.SPECIAL_ATTACK: return "special_attack"
		Stat.SPECIAL_DEFENSE: return "special_defense"
		Stat.SPEED: return "speed"
		Stat.ACCURACY: return "accuracy"
		Stat.EVASION: return "evasion"
	return ""

func get_last_learnable_moves() -> Array:
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

func get_random_ivs() -> void:
	hp_iv = randi() % 31
	attack_iv = randi() % 31
	defense_iv = randi() % 31
	special_attack_iv = randi() % 31
	special_defense_iv = randi() % 31
	speed_iv = randi() % 31 

func add_movepool_if_not_exists() -> void:
	if not has_node("Movepool"):
		movepool = Movepool.new()
		movepool.name = "Movepool"
		add_child(movepool)
		movepool.owner = self

func begin_of_turn() -> void:
	notify("TURN_STARTS")

func end_of_turn() -> void:
	notify("TURN_ENDS")

func _ready() -> void:
	Utils.add_node_if_not_exists(self, self, "SecondaryStatus")
	secondary_status = $SecondaryStatus
	Utils.add_node_if_not_exists(self, self, "MoveArchive")
	add_movepool_if_not_exists()
	movepool.pokemon = self
	calculate_stats()
	current_hp = hp

func _init() -> void:
	add_movepool_if_not_exists()

func init_battle() -> void:
	battlefield = battle.battlefield
	status_bar = battlefield.get_status_bar(field)
	calculate_stats()
	boosts = Boosts.new()
	boosts.name = "Boosts"
	boosts.pokemon = self
	boosts.boost_stats()
	add_child(boosts)

func switch_in() -> void:
	position = 0
	accuracy_level = 0
	evasion_level = 0
	notify("SWITCH_IN")

func switch_out() -> void:
	for status in secondary_status.get_children():
		status._heal_silent()
	notify("SWITCH_OUT")

func prepare_for_save(new_owner: Node) -> void:
	if has_node("Species"):
		remove_child($Species)
	if has_node("Nature"):
		remove_child($Nature)
	if has_node("Movepool"):
		movepool.prepare_for_save(new_owner)
