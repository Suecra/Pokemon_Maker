extends Node

const Utils = preload("res://Source/Scripts/Utils.gd")

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

var user
var targets = []
var battle
var turn

func _execute():
	if user.can_move():
		if _is_hit():
			_hit()
		else:
			battle.register_message(user.nickname + "s attack missed!")

func _hit():
	battle.register_message("But the move isn't implemented yet!")

func _get_base_damage():
	return power

func _get_accuracy():
	if accuracy == 0:
		return 100.0
	return float(accuracy)

func _is_hit():
	return Utils.trigger(_get_accuracy() / 100)

func get_type():
	return Utils.unpack(self, type, "Type")