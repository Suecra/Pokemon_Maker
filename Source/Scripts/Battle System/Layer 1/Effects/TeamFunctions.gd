extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var bag: Dictionary

func _init() -> void:
	cardinality = 1
	set_name("TeamFunctions")

func _register() -> void:
	._register()
	reg("use_item", 0, me())
	reg("can_use_item", 0, me())
	reg("get_battle_options", 0, me())

func use_item(item_name: String, fighter: Fighter) -> void:
	var item = battle.add_effect(fighter, "Items/" + item_name)
	delegate_e(item).v("use", [])
	bag[item_name] = bag[item_name] - 1

func can_use_item(item_name: String, fighter: Fighter) -> BattleBool:
	return BattleAnd.new(bag[item_name] > 0)

func get_battle_options() -> BattleArray:
	return BattleArray.new([0, 1, 2, 3])
