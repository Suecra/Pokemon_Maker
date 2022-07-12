extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const BattleVar = preload("res://Source/Scripts/Battle System/Layer 1/BattleVar.gd")
const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
const BattleAnd = preload("res://Source/Scripts/Battle System/Layer 1/BattleAnd.gd")
const BattleOr = preload("res://Source/Scripts/Battle System/Layer 1/BattleOr.gd")
const BattleAdd = preload("res://Source/Scripts/Battle System/Layer 1/BattleAdd.gd")
const BattleNumber = preload("res://Source/Scripts/Battle System/Layer 1/BattleNumber.gd")
const BattleMax = preload("res://Source/Scripts/Battle System/Layer 1/BattleMax.gd")
const BattleVarEntity = preload("res://Source/Scripts/Battle System/Layer 1/BattleVarEntity.gd")
const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")
const BattleInclude = preload("res://Source/Scripts/Battle System/Layer 1/BattleInclude.gd")

var names: Array
var owner: BattleEntity
var current_owner: BattleEntity
var effect_manager: Reference
var battle: Reference
var lasting_turns := -1

func _register() -> void:
	current_owner = owner
	reg("exists", 0, L1Consts.SenderType.BATTLEFIELD)
	reg("end_of_turn", 0, L1Consts.SenderType.BATTLEFIELD)

func set_name(name: String) -> void:
	names.append(name)

func is_type(name: String) -> bool:
	return names.has(name)

func reg(message: String, priority: int, sender_type: int) -> void:
	effect_manager.register(self, message, priority, sender_type)

func register_vars(vars: Array, sender_type: int) -> void:
	for v in vars:
		reg("get_" + v, 0, sender_type)

func v(message: String, params: Array) -> void:
	effect_manager.send(message, get_params(params), current_owner, null)
	current_owner = owner

func b(message: String, params: Array, default := false) -> BattleBool:
	var result = effect_manager.send(message, get_params(params), current_owner, BattleBool.new(default))
	current_owner = owner
	return result

func n(message: String, params: Array, default := 0) -> BattleNumber:
	var result = effect_manager.send(message, get_params(params), current_owner, BattleNumber.new(default))
	current_owner = owner
	return result

func ent(message: String, params: Array, default := null) -> BattleVarEntity:
	var result = effect_manager.send(message, get_params(params), current_owner, BattleVarEntity.new(default))
	current_owner = owner
	return result
	
func arr(message: String, params: Array, default := []) -> BattleArray:
	var result = effect_manager.send(message, get_params(params), current_owner, BattleArray.new(default))
	current_owner = owner
	return result

func get_params(params: Array) -> Array:
	var result = []
	for param in params:
		result.append(param.value)
	return result

func delegate(entity: BattleEntity) -> Reference:
	current_owner = entity
	return self

func delegate_e(effect: Reference) -> Reference:
	current_owner = effect.owner
	return self

func exists(effect_name: String) -> BattleBool:
	if is_type(effect_name):
		return BattleBool.new(true)
	return BattleBool.new(false)

func end_of_turn() -> void:
	lasting_turns = n("get_lasting_turns", [], lasting_turns).value
	if lasting_turns > -1:
		if lasting_turns == 0:
			battle.remove_effect(self)
		else:
			lasting_turns -= 1

func random_trigger(chance: float) -> BattleBool:
	return BattleBool.new(battle.random_trigger(chance))
