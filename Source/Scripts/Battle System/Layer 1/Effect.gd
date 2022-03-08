extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const BattleVar = preload("res://Source/Scripts/Battle System/Layer 1/BattleVar.gd")
const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
const BattleInt = preload("res://Source/Scripts/Battle System/Layer 1/BattleInt.gd")
const BattleFloat = preload("res://Source/Scripts/Battle System/Layer 1/BattleFloat.gd")
const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")

var names: Array
var owner: BattleEntity
var effect_manager: Reference
var battle: Reference

func _register() -> void:
	reg("exists", 0, L1Consts.SenderType.BATTLEFIELD)

func set_name(name: String) -> void:
	names.append(name)

func is_type(name: String) -> bool:
	return names.has(name)

func reg(message: String, priority: int, sender_type: int) -> void:
	effect_manager.register(self, message, priority, sender_type)

func v(message: String, params: Array) -> void:
	effect_manager.send(message, get_params(message, params), owner, 0)

func b(message: String, params: Array, default := false) -> bool:
	return effect_manager.send(message, get_params(message, params), owner, default)

func i(message: String, params: Array, default := 0) -> int:
	return effect_manager.send(message, get_params(message, params), owner, default)
	
func f(message: String, params: Array, default := 1) -> float:
	return effect_manager.send(message, get_params(message, params), owner, default)

func arr(message: String, params: Array, default := []) -> Array:
	return effect_manager.send(message, get_params(message, params), owner, default)

func get_params(message: String, params: Array) -> Array:
	var result = []
	for i in range(params.size()):
		result.append(effect_manager.send("get_" + message + "_" + L1Consts.MESSAGES[message][0][i]), [], owner, params[i])
	return result

func exists(effect_name: String) -> BattleBool:
	if is_type(effect_name):
		return BattleBool.new(true)
	return BattleBool.new(false)

func random_trigger(chance: float) -> BattleBool:
	return BattleBool.new(battle.random_trigger(chance))
