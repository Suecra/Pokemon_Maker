extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var priority := 0

func _init() -> void:
	set_name("TurnAction")
	lasting_turns = 0

func _register() -> void:
	._register()
	set_name("TurnAction")
	register_vars(["priority"], L1Consts.SenderType.SELF)
	reg("get_turn_actions", 0, L1Consts.SenderType.BATTLEFIELD)
	reg("get_reference_speed", 0, L1Consts.SenderType.SELF)
	reg("execute", 0, L1Consts.SenderType.SELF)
	reg("do_action", 0, L1Consts.SenderType.SELF)

func get_turn_actions() -> BattleArray:
	return BattleInclude.new([self])

func get_reference_speed() -> BattleNumber:
	return BattleNumber.new(n("get_speed", [true]).value)

func execute() -> void:
	v("do_action", [])
	battle.remove_effect(self)
