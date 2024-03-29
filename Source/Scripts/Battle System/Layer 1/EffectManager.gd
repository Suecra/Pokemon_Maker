extends Reference

const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")
const BattleVar = preload("res://Source/Scripts/Battle System/Layer 1/BattleVar.gd")
const BattleBool = preload("res://Source/Scripts/Battle System/Layer 1/BattleBool.gd")
const BattleNumber = preload("res://Source/Scripts/Battle System/Layer 1/BattleNumber.gd")
const BattleVarEntity = preload("res://Source/Scripts/Battle System/Layer 1/BattleVarEntity.gd")
const BattleArray = preload("res://Source/Scripts/Battle System/Layer 1/BattleArray.gd")

var registered_effects := {}

func register(effect, message: String, priority: int, roles: Array, sorted: bool) -> void:
	if not registered_effects.has(message):
		registered_effects[message] = []
	registered_effects[message].append(RegisteredEffect.new(effect, priority, roles, sorted))

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

func send(message: String, params: Array, sender, default: BattleVar):
	var result = default
	if not message.begins_with("can_") && not send("can_" + message, params, sender, BattleBool.new(true)):
		return null
	if registered_effects.has(message):
		var reg_effects = registered_effects[message]
		reg_effects.sort_custom(self, "sort")
		for registered_effect in reg_effects:
			var effect = registered_effect.effect
			var role = effect.get_entity_relation(sender)
			if L1Consts.contains_role(registered_effect.roles, role):
				var can_receive = true
				if message != "can_receive":
					can_receive = send("can_receive", [sender, effect], sender, BattleBool.new(can_receive)).value
				if can_receive:
					call_method(effect, message, params, result)
	return result

func call_method(effect, message: String, params: Array, result: BattleVar) -> void:
	if effect.has_method(message):
		var next_result = effect.callv(message, params)
		if next_result != null:
			next_result._concat(result)
	else:
		var var_name = message.substr(4, -1)
		var v = effect.get(var_name)
		if result._get_type() == L1Consts.MessageType.NUMBER:
			BattleNumber.new(v)._concat(result)
		elif result._get_type() == L1Consts.MessageType.BOOL:
			BattleBool.new(v)._concat(result)

func sort(a, b) -> bool:
	if a.priority < b.priority:
		return true
	elif a.priority == b.priority:
		if not a.sorted or not b.sorted:
			return a < b
		var ref_speed_a = send("get_reference_speed", [], a.effect, BattleNumber.new(0)).value
		var ref_speed_b = send("get_reference_speed", [], b.effect, BattleNumber.new(0)).value
		if ref_speed_a > ref_speed_b:
			return true
	return false
