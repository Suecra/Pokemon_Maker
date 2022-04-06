extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var priority := 0

func _register() -> void:
	._register()
	reg("get_turn_actions", 0, L1Consts.SenderType.BATTLEFIELD)
	reg("get_priority", 0, L1Consts.SenderType.SELF)
	reg("get_reference_speed", 0, L1Consts.SenderType.SELF)
	reg("execute", 0, L1Consts.SenderType.SELF)

func get_priority() -> BattleInt:
	return BattleInt.new(priority)
