extends "res://Source/Scripts/Battle System/Layer 1/Effects/FieldTurnAction.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var fighter: Fighter

func init() -> void:
	priority = 6
	set_name("Switch")
	reg("switch", 0, L1Consts.SenderType.SELF)

func do_action() -> void:
	if b("can_switch_out", []) && delegate(fighter).b("can_switch_in", []):
		v("switch", [])

func switch() -> void:
	owner.active = false
	fighter.position = owner.position
	fighter.active = true
