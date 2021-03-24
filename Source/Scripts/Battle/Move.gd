extends "res://Source/Scripts/Battle/HalfTurn.gd"

export(String) var move_name
export(int) var current_pp setget set_current_pp

var target_index: int
var targets = []
var data: Node setget ,get_move_data
var damage_messages = []

func _get_priority() -> int:
	if self.data != null:
		return self.data.priority
	return ._get_priority()

func set_current_pp(value: int) -> void:
	current_pp = min(value, self.data.pp)
	current_pp = max(current_pp, 0)

func get_move_data() -> Node:
	if not has_node("Data"):
		load_move()
	return $Data

func load_move() -> void:
	data = Move.new(move_name)
	data.name = "Data"
	add_child(data)
	data.owner = self

func _can_use() -> bool:
	return current_pp > 0

func restore_pp() -> void:
	if self.data != null:
		current_pp = self.data.pp

func _execute() -> void:
	current_pp -= 1
	if pokemon.can_move(self.data.move_name):
		var target_positions = self.data.get_target_positions(pokemon.position, target_index)
		targets = battle.battlefield.get_targets(target_positions, field)
		battle.register_message(pokemon.nickname + " uses " + self.data.get_move_name() + "!")
		for target in targets:
			if affects(target):
				if _is_hit(target):
					_hit(target)
				else:
					battle.register_message(target.nickname + " avoided the attack!")
			else:
				battle.register_message("It doesn't affect " + target.nickname + "!")

func _hit(target: Node) -> void:
	damage_messages = []
	if self.data.damage_class != Move.DamageClass.Status:
		deal_damage(target)
	trigger_effects(target)

func deal_damage(target: Node) -> void:
	var damage = floor(pokemon.level * 2 / 5) + 2
	damage *= self.data.power
	damage *= _get_attack()
	damage = floor(damage / (50 * _get_defense(target)))
	damage = floor(damage * _get_factor1())
	damage += 2
	damage = floor(damage * _get_crit_multiplier())
	damage = floor(damage * get_damage_roll())
	damage = floor(damage * _get_STAB_multiplier())
	damage = floor(damage * _get_damage_multiplier(target))
	damage = max(damage, 1)
	target.damage(damage, damage_messages)

func _get_attack() -> int:
	if self.data.damage_class == Move.DamageClass.Physical:
		return pokemon.current_attack
	if self.data.damage_class == Move.DamageClass.Special:
		return pokemon.current_special_attack
	return 0

func _get_defense(target: Node) -> int:
	if self.data.damage_class == Move.DamageClass.Physical:
		return target.current_defense
	if self.data.damage_class == Move.DamageClass.Special:
		return target.current_special_defense
	return 0
	
func _get_factor1() -> float:
	if targets.size() > 1:
		return 0.75
	return 1.0

func _get_crit_multiplier() -> float:
	if _is_critical_hit():
		damage_messages.append("A critical hit!")
		return 1.5
	return 1.0
	pass

func _is_critical_hit() -> bool:
	var crit_level = 1
	#TODO: Implement crit_level
	match crit_level:
		1: return Utils.trigger(0.0416)
		2: return Utils.trigger(0.125)
		3: return Utils.trigger(0.5)
		4: return true
	return false

func get_damage_roll() -> float:
	return float(randi() % 16 + 85) / 100

func _get_STAB_multiplier() -> float:
	if _is_STAB():
		return 1.5
	return 1.0

func _is_STAB() -> bool:
	var types = pokemon.get_types()
	for type in types:
		if type.id == self.data.get_type().id:
			return true
	return false

func _get_damage_multiplier(target: Node) -> float:
	return self.data.get_type().get_damage_multiplier(target.get_types())

func _get_damage_multiplier_message(multiplier: float) -> void:
	if multiplier > 1:
		damage_messages.append("It's very effective!")
	if multiplier < 1:
		damage_messages.append("It's not very effective!")

func _get_accuracy(accuracy_level: int) -> float:
	var acc = self.data.accuracy
	if acc == 0:
		acc = 100
	var actual_accuracy = 1.0
	match accuracy_level:
		-6: actual_accuracy = 0.33
		-5: actual_accuracy = 0.38
		-4: actual_accuracy = 0.43
		-3: actual_accuracy = 0.5
		-2: actual_accuracy = 0.6
		-1: actual_accuracy = 0.75
		0: actual_accuracy = 1.0
		1: actual_accuracy = 1.33
		2: actual_accuracy = 1.67
		3: actual_accuracy = 2
		4: actual_accuracy = 2.33
		5: actual_accuracy = 2.67
		6: actual_accuracy = 3
	return min(100, actual_accuracy * acc)

func _is_hit(target: Node) -> bool:
	return Utils.trigger(_get_accuracy(pokemon.accuracy_level - target.evasion_level) / 100)

func affects(target: Node) -> bool:
	return _get_damage_multiplier(target) != 0.0

func trigger_effects(target: Node) -> void:
		for effect in self.data.get_effects():
			effect.user = pokemon
			effect.target = target
			effect.trigger()
