extends Node

enum DamageClass {Physical, Special, Status}
enum Flags {Contact, Protect, Mirrorable, Kings_Rock, Sky_Battle, Damage, Ailment, Heal, Punch, Lower, Raise, OHKO, Field_Effect, Whole_Field_Effect}
enum HitRange {Opponent, All_Opponents, All, User, Partner, User_or_Partner, User_Field, Opponent_Field, Entire_Field}
enum ContestType {Cool, Beauty, Cute, Smart, Tough}

export(String) var move_name
export(PackedScene) var type
export(DamageClass) var damage_class
export(int, 1, 255) var power
export(int, 0, 100) var accuracy
export(int, -7, 7) var priority
export(int) var pp
export(int, 1, 255) var z_power

export(Flags, FLAGS) var flags
export(HitRange) var hit_range
export(bool) var is_HM

export(ContestType) var contest_type
export(PackedScene) var contest_effect
export(int, "Attack", "Defense", "Support") var battle_style
export(String) var description

onready var effects = $Effects

var user: Node
var targets := []
var battle: Node
var turn: Node

func _execute() -> void:
	for target in targets:
		if _is_hit(target):
			_hit(target)
		else:
			battle.register_message(target.nickname + " avoided the attack!")

func _hit(target: Node) -> void:
	trigger_effects(target)

func trigger_effects(target: Node) -> void:
	if effects != null:
		for effect in effects.get_children():
			effect.user = user
			effect.target = target
			effect.trigger()

func _get_base_damage() -> int:
	return power

func _get_accuracy(accuracy_level: int) -> float:
	var acc = accuracy
	if acc == 0:
		acc = 100
	var actual_accuracy = 1.0
	match accuracy_level:
		-6: actual_accuracy = 0.33
		-5: actual_accuracy = 0.38
		-4: actual_accuracy = 0.43
		-3: actual_accuracy = 0.5
		-2: actual_accuracy = 0.6
		-1: actual_accuracy = 0.75
		0: actual_accuracy = 1.0
		1: actual_accuracy = 1.33
		2: actual_accuracy = 1.67
		3: actual_accuracy = 2
		4: actual_accuracy = 2.33
		5: actual_accuracy = 2.67
		6: actual_accuracy = 3
	return min(100, actual_accuracy * acc)

func _is_hit(target: Node) -> bool:
	return Utils.trigger(_get_accuracy(user.accuracy_level - target.evasion_level) / 100)

func get_type() -> Node:
	return Utils.unpack(self, type, "Type")

func get_possible_target_positions(user_position: int) -> Array:
	var result = []
	if hit_range == HitRange.Opponent:
		result.append(user_position + 3)
	elif hit_range == HitRange.User:
		result.append(user_position)
	else:
		result.append(user_position + 3)
	return result

func get_target_positions(user_position: int, index: int) -> Array:
	var result = []
	var possible_target_positions = get_possible_target_positions(user_position)
	if has_target_choice():
		if index < possible_target_positions.size():
			result.append(possible_target_positions[index])
	else:
		result = possible_target_positions
	return result

func has_target_choice() -> bool:
	match hit_range:
		HitRange.Opponent, HitRange.User_or_Partner: return true
	return false
