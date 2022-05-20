extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var speed: int

func _init() -> void:
	set_name("Stats")

func _register() -> void:
	._register()
	reg("get_speed", 0, L1Consts.SenderType.SELF)
	reg("get_max_speed", 0, L1Consts.SenderType.SELF_OR_ALLY)
	reg("get_opponent_max_speed", 0, L1Consts.SenderType.OPPONENT)

func get_speed(modified: bool) -> BattleFloat:
	return BattleFloat.new(speed)
	
func get_max_speed(modified: bool) -> BattleFloat:
	return BattleMax.new(f("get_speed", []).value)

func get_opponent_max_speed(modified: bool) -> BattleFloat:
	return BattleMax.new(f("get_speed", []).value)
