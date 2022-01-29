extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")
const BattleVar = preload("res://Source/Scripts/Battle System/Layer 1/BattleVar.gd")
const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
const BattleInt = preload("res://Source/Scripts/Battle System/Layer 1/BattleInt.gd")
const BattleFloat = preload("res://Source/Scripts/Battle System/Layer 1/BattleFloat.gd")
const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")

var registered_effects := {}

func register(effect, message: String, priority: int, sender_type: int) -> void:
	if not registered_effects.has(message):
		registered_effects[message] = []
	registered_effects[message].append(RegisteredEffect.new(effect, priority, sender_type))

func send(message: String, params: Array, sender: BattleEntity):
	var result
	match L1Consts.MESSAGES[message][0]:
		L1Consts.MessageType.BOOL: result = BattleBool.new(false)
		L1Consts.MessageType.INT: result = BattleInt.new(0)
		L1Consts.MessageType.FLOAT: result = BattleFloat.new(1)
		L1Consts.MessageType.ARRAY: result = BattleArray.new([])
	
	if registered_effects.has(message):
		var reg_effects = registered_effects[message]
		reg_effects.sort_custom(RegisteredEffectSorter, "sort")
		for registered_effect in reg_effects:
			var effect = registered_effect.effect
			var role = effect.owner._get_entity_relation(sender)
			if L1Consts.is_sender_type(registered_effect.sender_type, role):
				call_method(effect, message, params, result)
	if result == null:
		return null
	return result.value

func call_method(effect, message: String, params: Array, result: BattleVar) -> void:
	if effect.has_method(message):
		var next_result = effect.callv(message, params)
		if next_result != null:
			next_result.concat(result)

class RegisteredEffectSorter:
	static func sort(a, b) -> bool:
		if a.priority < b.priority:
			return true
		return false
