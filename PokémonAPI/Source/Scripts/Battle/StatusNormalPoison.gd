extends "res://Source/Scripts/Battle/StatusPoison.gd"

const DAMAGE = 1.0 / 8.0

func _end_of_turn():
	battle.register_message(subject_owner.nickname + " was hurt from it's poision!")
	register_damage(subject_owner.damage_percent(DAMAGE))
	if subject_owner.fainted():
		register_faint(subject_owner)
		battle.register_message(subject_owner.nickname + " has fainted!")

func _ready():
	status_name = "Poision"
	register(subject_owner, "TURN_ENDS", "_end_of_turn")
	battle.register_message(subject_owner.nickname + " was poisoned!")