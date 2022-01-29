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
	pass

func set_name(name: String) -> void:
	names.append(name)

func is_type(name: String) -> bool:
	return names.has(name)

func reg(message: String, priority: int, sender_type: int) -> void:
	effect_manager.register(self, message, priority, sender_type)

func v(message: String, params: Array) -> void:
	effect_manager.send(message, params, owner)

func b(message: String, params: Array) -> bool:
	return effect_manager.send(message, params, owner)

func i(message: String, params: Array) -> int:
	return effect_manager.send(message, params, owner)
	
func f(message: String, params: Array) -> float:
	return effect_manager.send(message, params, owner)

func arr(message: String, params: Array) -> Array:
	return effect_manager.send(message, params, owner)
