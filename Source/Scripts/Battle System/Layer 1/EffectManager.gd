extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")

var registered_effects: Dictionary

func register(effect: Effect, message: String, priority: int, sender_type: int) -> void:
	if not registered_effects.has(message):
		registered_effects[message] = []
	registered_effects[message].append(RegisteredEffect.new(effect, priority, sender_type))

func send(message: String, params: Array, sender: BattleEntity):
	var result
	var registered_effects = registered_effects[message]
	registered_effects.sort_custom(RegisteredEffectSorter, "sort")
	for registered_effect in registered_effects:
		var effect = registered_effect.effect
		var sender_type = effect.owner._get_entity_relation(sender)
		if registered_effect.sender_type == sender_type:
			if effect.has_method(message):
				result = effect.callv(message, params)
	return result

class RegisteredEffectSorter:
	static func sort(a, b) -> bool:
		if a.priority < b.priority:
			return true
		return false
