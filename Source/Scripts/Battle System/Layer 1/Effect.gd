extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const BattleVar = preload("res://Source/Scripts/Battle System/Layer 1/BattleVar.gd")
const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
const BattleAnd = preload("res://Source/Scripts/Battle System/Layer 1/BattleAnd.gd")
const BattleOr = preload("res://Source/Scripts/Battle System/Layer 1/BattleOr.gd")
const BattleAdd = preload("res://Source/Scripts/Battle System/Layer 1/BattleAdd.gd")
const BattleMult = preload("res://Source/Scripts/Battle System/Layer 1/BattleMult.gd")
const BattleNumber = preload("res://Source/Scripts/Battle System/Layer 1/BattleNumber.gd")
const BattleMax = preload("res://Source/Scripts/Battle System/Layer 1/BattleMax.gd")
const BattleVarEntity = preload("res://Source/Scripts/Battle System/Layer 1/BattleVarEntity.gd")
const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")
const BattleInclude = preload("res://Source/Scripts/Battle System/Layer 1/BattleInclude.gd")

var names: Array
var owner: BattleEntity
var current_owner: BattleEntity
var current_effect: Reference
var effect_manager: Reference
var battle: Reference
var battlefield: Reference
var lasting_turns := -1
var cardinality := -1
var replace_mode = L1Consts.EffectReplaceMode.NONE

func _register() -> void:
	current_effect = self
	current_owner = owner
	reg("exists", 0, all_roles())
	reg("end_of_turn", 0, [L1Consts.Role.BATTLEFIELD])
	reg("random_trigger", 0, [L1Consts.Role.SELF])

func set_name(name: String) -> void:
	names.append(name)

func is_type(name: String) -> bool:
	return names.has(name)

func get_entity_relation(effect) -> int:
	if effect == null:
		return L1Consts.Role.BATTLEFIELD
	if effect == self:
		return L1Consts.Role.SELF
	return current_owner._get_entity_relation(effect.current_owner)

func reg(message: String, priority: int, roles: Array, sorted: bool = true) -> void:
	effect_manager.register(self, message, priority, roles, sorted)

func register_vars(vars: Array, roles: Array) -> void:
	for v in vars:
		reg("get_" + v, 0, roles)

func me() -> Array:
	return [L1Consts.Role.SELF, L1Consts.Role.OWNER]

func self_or_ally() -> Array:
	return [L1Consts.Role.SELF, L1Consts.Role.OWNER, L1Consts.Role.ALLY]

func all_roles() -> Array:
	return [L1Consts.Role.SELF, L1Consts.Role.OWNER, L1Consts.Role.ALLY, L1Consts.Role.OPPONENT, L1Consts.Role.BATTLEFIELD]

func v(message: String, params: Array) -> void:
	effect_manager.send(message, params, current_effect, null)
	current_effect = self
	current_owner = owner

func b(message: String, params: Array, default := false) -> bool:
	var result = effect_manager.send(message, params, current_effect, BattleBool.new(default))
	current_effect = self
	current_owner = owner
	return result.value

func f(message: String, params: Array, default := 0) -> float:
	var result = effect_manager.send(message, params, current_effect, BattleNumber.new(default))
	current_effect = self
	current_owner = owner
	return result.value

func i(message: String, params: Array, default := 0) -> int:
	var result = effect_manager.send(message, params, current_effect, BattleNumber.new(default))
	current_effect = self
	current_owner = owner
	return int(result.value)

func ent(message: String, params: Array, default := null) -> BattleEntity:
	var result = effect_manager.send(message, params, current_effect, BattleVarEntity.new(default))
	current_effect = self
	current_owner = owner
	return result.value
	
func arr(message: String, params: Array, default := []) -> Array:
	var result = effect_manager.send(message, params, current_effect, BattleArray.new(default))
	current_effect = self
	current_owner = owner
	return result.value

func delegate(entity: BattleEntity) -> Reference:
	current_owner = entity
	return self

func delegate_e(effect: Reference) -> Reference:
	current_effect = effect
	current_owner = effect.owner
	return self

func exists(effect_name: String) -> BattleBool:
	if is_type(effect_name):
		return BattleBool.new(true)
	return BattleBool.new(false)

func end_of_turn() -> void:
	lasting_turns = i("get_lasting_turns", [], lasting_turns)
	if lasting_turns > -1:
		if lasting_turns == 0:
			battle.remove_effect(self)
		else:
			lasting_turns -= 1

func random_trigger(chance: float) -> BattleBool:
	return BattleBool.new(battle.random_trigger(chance))
