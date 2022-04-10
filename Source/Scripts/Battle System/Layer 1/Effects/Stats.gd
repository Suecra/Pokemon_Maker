extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var speed: int

func _register() -> void:
	._register()
	set_name("Stats")
	reg("get_speed", 0, L1Consts.SenderType.SELF)
	reg("get_max_speed", 0, L1Consts.SenderType.SELF_OR_ALLY)

func get_max_speed() -> BattleFloat:
	return BattleMax.new(f("get_speed", []).value)

func get_speed() -> BattleInt:
	return BattleInt.new(speed)
