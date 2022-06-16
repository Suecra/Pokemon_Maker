extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var index: int
var pp: int
var move_name: String
var move_type: int
var move_priority: int
var move_effects: Array
var possible_targets: int

func _init() -> void:
	set_name("Move")

func _register() -> void:
	._register()
	reg("execute_move", 0, L1Consts.SenderType.SELF)
	reg("get_move_priority", 0, L1Consts.SenderType.SELF)
	reg("get_display_pp", 0, L1Consts.SenderType.SELF)
	reg("get_display_name", 0, L1Consts.SenderType.SELF)
	reg("get_display_type", 0, L1Consts.SenderType.SELF)
	reg("get_possible_targets", 0, L1Consts.SenderType.SELF)

func execute_move(move_name: String, target_positions: Array) -> void:
	if move_name == self.move_name:
		var effects = arr("get_move_effects", [], move_effects)
		for effect in effects:
			battle.add_effect(owner, "MoveEffects/" + effect)
		v("do_move", [target_positions])

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

func get_possible_targets(index: int) -> BattleNumber:
	if index == self.index:
		return BattleNumber.new(possible_targets)
	return BattleAdd.new(0)
