extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var bag: Dictionary

func _register() -> void:
	._register()
	set_name("TeamFunctions")
	reg("use_item", 0, L1Consts.SenderType.SELF)
	reg("can_use_item", 0, L1Consts.SenderType.SELF)

func use_item(item_name: String, fighter: Fighter) -> void:
	var item = battle.add_effect(fighter, "Items/" + item_name)
	delegate_e(item).v("use", [])
	bag[item_name] = bag[item_name] - 1

func can_use_item(item_name: String, fighter: Fighter) -> BattleBool:
	return BattleAnd.new(bag[item_name] > 0)
