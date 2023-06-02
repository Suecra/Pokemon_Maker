extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var index: int
var pp: int
var move_name: String
var move_type: int
var move_category: int
var move_priority: int
var move_effects: Array
var target_type: int

func _init() -> void:
	set_name("Move")

func _register() -> void:
	._register()
	reg("execute_move", 0, me())
	reg("get_move", 0, all_roles())
	reg("get_target_type", 0, all_roles())
	reg("get_move_priority", 0, me())
	reg("get_display_pp", 0, me())
	reg("get_display_type", 0, me())
	reg("get_display_category", 0, me())
	reg("get_possible_targets", 0, me())
	reg("get_target_positions", 0, me())

func execute_move(move_name: String, target_index: int) -> void:
	if move_name == self.move_name:
		var effects = arr("get_move_effects", [], move_effects)
		for effect in effects:
			var move_effect = battle.add_effect(owner, "MoveEffects/" + effect["name"])
			for key in effect["params"].keys():
				move_effect.set(key, effect["params"][key])
		var target_positions = arr("get_target_positions", [index, target_index])
		v("do_move", [target_positions])

func get_move(fighter) -> BattleArray:
	if fighter == owner:
		return BattleInclude.new([self])
	return BattleInclude.new([])

func get_move_priority() -> BattleNumber:
	return BattleNumber.new(move_priority)

func get_display_pp(index: int) -> BattleNumber:
	if index == self.index:
		return BattleNumber.new(pp)
	return BattleAdd.new(0)
	
func get_display_type(index: int) -> BattleNumber:
	if index == self.index:
		return BattleNumber.new(move_type)
	return BattleAdd.new(0)

func get_display_category(index: int) -> BattleNumber:
	if index == self.index:
		return BattleNumber.new(move_category)
	return BattleAdd.new(0)

func get_target_type(fighter, index: int) -> BattleNumber:
	if fighter == owner && index == self.index:
		return BattleNumber.new(target_type)
	return BattleAdd.new(0)

func get_target_positions(move_index: int, target_index: int) -> BattleArray:
	if move_index == index:
		return BattleArray.new(L1Consts.get_target_positions(target_type, owner.position, target_index, battlefield.size))
	return BattleInclude.new([])
