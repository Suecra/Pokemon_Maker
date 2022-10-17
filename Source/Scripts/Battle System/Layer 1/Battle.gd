extends Reference

const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const EffectFactory = preload("res://Source/Scripts/Battle System/Layer 1/EffectFactory.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")

var battle_l0: BattleL0
var effect_manager: EffectManager
var effect_factory: EffectFactory
var effects: Dictionary

func start() -> void:
	effects.clear()
	battle_l0.start()

func add_effect(owner: BattleEntity, name: String) -> Effect:
	if not effects.has(owner):
		effects[owner] = []
	var effect = effect_factory.create_effect(name, owner)
	if effect.cardinality != -1:
		var count = 0
		for e in effects[owner]:
			if e.is_type(name):
				count += 1
		if count == effect.cardinality:
			match effect.replace_mode:
				L1Consts.EffectReplaceMode.NONE:
					return effects[owner][effects[owner].size() - 1]
				L1Consts.EffectReplaceMode.FIFO:
					effects[owner].remove(0)
				L1Consts.EffectReplaceMode.LIFO:
					effects[owner].remove(effects[owner].size() - 1)
	effect.effect_manager = effect_manager
	effect.battle = self
	effect.battlefield = battle_l0.battlefield
	effect._register()
	effects[owner].append(effect)
	return effect

func get_effects(owner: BattleEntity, name: String) -> Array:
	var result = []
	if effects.has(owner):
		var effect_list = effects[owner]
		for effect in effect_list:
			if effect.is_type(name):
				result.append(effect)
	return result

func remove_effect(effect: Reference) -> void:
	effects[effect.owner].erase(effect)
	effect_manager.unregister(effect)

func remove_effects(owner: BattleEntity, name: String) -> void:
	if effects.has(owner):
		var effect_list = effects[owner]
		var i = 0
		while i < effect_list.size():
			var effect = effect_list[i]
			if effect.is_type(name):
				remove_effect(effect)
			else:
				i += 1

func random_trigger(chance: float) -> bool:
	return Utils.trigger(chance)

func random_select(list: Array):
	var idx = randi() % list.size()
	return list[idx]

func random_number(lower_bound: float, upper_bound: float) -> float:
	return rand_range(lower_bound, upper_bound)

func nudge_effects() -> void:
	effect_manager.send("nudge", [], battle_l0.battlefield, null)

func _init() -> void:
	effect_factory = EffectFactory.new()
	battle_l0 = BattleL0.new()
