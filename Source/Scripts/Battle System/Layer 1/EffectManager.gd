extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")
const BattleVar = preload("res://Source/Scripts/Battle System/Layer 1/BattleVar.gd")
const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
const BattleInt = preload("res://Source/Scripts/Battle System/Layer 1/BattleInt.gd")
const BattleFloat = preload("res://Source/Scripts/Battle System/Layer 1/BattleFloat.gd")
const BattleVarEntity = preload("res://Source/Scripts/Battle System/Layer 1/BattleVarEntity.gd")
const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")

var registered_effects := {}

func register(effect, message: String, priority: int, sender_type: int) -> void:
	if not registered_effects.has(message):
		registered_effects[message] = []
	registered_effects[message].append(RegisteredEffect.new(effect, priority, sender_type))

func unregister(effect) -> void:
	for message in registered_effects.keys():
		var reg_effects = registered_effects[message]
		var i = 0
		while i < reg_effects.size():
			if reg_effects[i].effect == effect:
				reg_effects.remove(i)
			else:
				i += 1
		if reg_effects.size() == 0:
			registered_effects.erase(message)

func send(message: String, params: Array, sender: BattleEntity, default):
	var result
	if message.begins_with("can_"):
		result = BattleBool.new(default)
	else:
		match L1Consts.MESSAGES[message][1]:
			L1Consts.MessageType.BOOL: result = BattleBool.new(default)
			L1Consts.MessageType.INT: result = BattleInt.new(default)
			L1Consts.MessageType.FLOAT: result = BattleFloat.new(default)
			L1Consts.MessageType.ENTITY: result = BattleVarEntity.new(default)
			L1Consts.MessageType.ARRAY: result = BattleArray.new(default)
			L1Consts.MessageType.VOID:
				if not send("can_" + message, params, sender, true):
					return null
	
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
			next_result._concat(result)

class RegisteredEffectSorter:
	static func sort(a, b) -> bool:
		if a.priority < b.priority:
			return true
		return false
