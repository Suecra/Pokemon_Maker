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
	cardinality = 1
	set_name("Stats")

func _register() -> void:
	._register()
	register_vars(["level", "gender", "attack", "defense", "special_attack", "special_defense", "weight", "happiness"], me())
	reg("get_hp", 0, me())
	reg("get_speed", 0, me(), false)
	reg("get_max_speed", 0, self_or_ally(), false)
	reg("get_opponent_max_speed", 0, [L1Consts.Role.OPPONENT])

func get_hp() -> BattleNumber:
	return BattleNumber.new(owner.hp)

func get_speed(modified: bool) -> BattleNumber:
	return BattleNumber.new(speed)
	
func get_max_speed(modified: bool) -> BattleNumber:
	return BattleMax.new(f("get_speed", [modified]))

func get_opponent_max_speed(modified: bool) -> BattleNumber:
	return BattleMax.new(f("get_speed", [modified]))
