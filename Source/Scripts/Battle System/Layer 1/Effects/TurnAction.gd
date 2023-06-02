extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var priority := 0

func _init() -> void:
	set_name("TurnAction")
	lasting_turns = 0

func _register() -> void:
	._register()
	register_vars(["priority"], [L1Consts.Role.SELF])
	reg("get_turn_actions", 0, all_roles())
	reg("get_reference_speed", 0, [L1Consts.Role.SELF], false)
	reg("execute", 0, [L1Consts.Role.SELF])
	reg("do_action", 0, [L1Consts.Role.SELF])

func get_priority() -> BattleNumber:
	return BattleNumber.new(priority)

func get_turn_actions() -> BattleArray:
	return BattleInclude.new([self])

func get_reference_speed() -> BattleNumber:
	return BattleNumber.new(f("get_speed", [true]))

func execute() -> void:
	v("do_action", [])
	battle.remove_effect(self)
