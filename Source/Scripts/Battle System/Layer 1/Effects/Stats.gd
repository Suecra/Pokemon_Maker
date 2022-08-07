extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var level: int
var gender: int
var attack: int
var defense: int
var special_attack: int
var special_defense: int
var speed: int
var weight: int
var happiness: int

func _init() -> void:
	set_name("Stats")

func _register() -> void:
	._register()
	register_vars(["level", "gender", "attack", "defense", "special_attack", "special_defense", "speed", "weight", "happiness"], L1Consts.SenderType.SELF)
	reg("get_hp", 0, L1Consts.SenderType.SELF_OR_ALLY)
	reg("get_max_speed", 0, L1Consts.SenderType.SELF_OR_ALLY)
	reg("get_opponent_max_speed", 0, L1Consts.SenderType.OPPONENT)

func get_hp() -> BattleNumber:
	return BattleNumber.new(owner.hp)

func get_speed(modified: bool) -> BattleNumber:
	return BattleNumber.new(speed)
	
func get_max_speed(modified: bool) -> BattleNumber:
	return BattleMax.new(n("get_speed", [modified]).value)

func get_opponent_max_speed(modified: bool) -> BattleNumber:
	return BattleMax.new(n("get_speed", [modified]).value)
