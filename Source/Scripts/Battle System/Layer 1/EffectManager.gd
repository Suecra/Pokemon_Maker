extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")
const BattleVar = preload("res://Source/Scripts/Battle System/Layer 1/BattleVar.gd")
const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
const BattleInt = preload("res://Source/Scripts/Battle System/Layer 1/BattleInt.gd")
const BattleFloat = preload("res://Source/Scripts/Battle System/Layer 1/BattleFloat.gd")
const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")

var registered_effects: Dictionary

func register(effect: Effect, message: String, priority: int, sender_type: int) -> void:
	if not registered_effects.has(message):
		registered_effects[message] = []
	registered_effects[message].append(RegisteredEffect.new(effect, priority, sender_type))

func send(message: String, params: Array, sender: BattleEntity):
	var result
	match L1Consts.MESSAGES[message][0]:
		L1Consts.MessageType.VOID: result = BattleVar.new()
		L1Consts.MessageType.BOOL: result = BattleBool.new(false)
		L1Consts.MessageType.INT: result = BattleInt.new(0)
		L1Consts.MessageType.FLOAT: result = BattleFloat.new(1)
		L1Consts.MessageType.ARRAY: result = BattleArray.new([])
	
	var registered_effects = registered_effects[message]
	registered_effects.sort_custom(RegisteredEffectSorter, "sort")
	for registered_effect in registered_effects:
		var effect = registered_effect.effect
		var sender_type = effect.owner._get_entity_relation(sender)
		match sender_type:
			L1Consts.SenderType.SELF_OR_ALLY:
				if registered_effect.sender_type == L1Consts.SenderType.SELF || registered_effect.sender_type == L1Consts.SenderType.ALLY:
					call_method(effect, message, params, result)
			L1Consts.SenderType.BATTLEFIELD:
				call_method(effect, message, params, result)
			var other:
				if registered_effect.sender_type == other:
					call_method(effect, message, params, result)
	return result.value

func call_method(effect: Effect, message: String, params: Array, result: BattleVar) -> void:
	if effect.has_method(message):
		effect.callv(message, params).concat(result)

class RegisteredEffectSorter:
	static func sort(a, b) -> bool:
		if a.priority < b.priority:
			return true
		return false
