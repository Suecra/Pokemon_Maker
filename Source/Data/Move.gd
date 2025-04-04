extends "res://Source/Data/PMDataObject.gd"

class_name Move

enum DamageClass {Physical, Special, Status}
enum Flags {Contact, Protect, Mirrorable, Kings_Rock, Sky_Battle, Damage, Ailment, Heal, Punch, Lower, Raise, OHKO, Field_Effect, Whole_Field_Effect}
enum HitRange {Opponent, All_Opponents, All, User, Partner, User_or_Partner, User_Field, Opponent_Field, Entire_Field}
enum ContestType {Cool, Beauty, Cute, Smart, Tough}

export(String) var move_name
export(PackedScene) var type
export(int) var type_id
export(DamageClass) var damage_class
export(int, 0, 255) var power
export(int, 0, 100) var accuracy
export(int, -7, 7) var priority
export(int) var pp
export(int, 0, 255) var z_power

export(Flags, FLAGS) var flags
export(HitRange) var hit_range
export(bool) var is_HM

export(ContestType) var contest_type
export(PackedScene) var contest_effect
export(int, "Attack", "Defense", "Support") var battle_style
export(String) var description
export(Array) var effect_array
export(int) var target_type

onready var effects = $Effects

func get_move_name() -> String:
	return move_name.capitalize()

func _init(name: String = "") -> void:
	if name != "":
		load_from_file(Consts.MOVE_PATH + name + ".json")

func _load_from_json(data: Dictionary) -> void:
	target_type = 0
	move_name = data["name"]
	name = move_name
	type = load(Consts.TYPE_PATH + data["type"]["name"] + ".tscn")
	var temp = type.instance()
	type_id = temp.id
	match data["damage_class"]["name"]:
		"status": damage_class = DamageClass.Status
		"physical": damage_class = DamageClass.Physical
		"special": damage_class = DamageClass.Special
	power = 0
	if data.has("power") && data["power"] != null:
		power = int(data["power"])
	if data.has("accuracy") && data["accuracy"] != null:
		accuracy = int(data["accuracy"])
	if data.has("priority") && data["priority"] != null:
		priority = int(data["priority"])
	if data.has("pp") && data["pp"] != null:
		pp = int(data["pp"])
	
	if data["target"]["name"].find("selected-pokemon") != -1:
		hit_range = HitRange.Opponent
	elif data["target"]["name"] == "all-opponents" || data["target"]["name"] == "random-opponent":
		hit_range = HitRange.All_Opponents
	elif data["target"]["name"] == "all-other-pokemon":
		hit_range = HitRange.All
	elif data["target"]["name"] == "user" || data["target"]["name"] == "specific-move":
		hit_range = HitRange.User
	elif data["target"]["name"] == "ally":
		hit_range = HitRange.Partner
	elif data["target"]["name"] == "user-or-ally":
		hit_range = HitRange.User_or_Partner
	elif data["target"]["name"] == "users-field" || data["target"]["name"] == "user-and-allies":
		hit_range = HitRange.User_Field
	elif data["target"]["name"] == "opponents-field":
		hit_range = HitRange.Opponent_Field
	elif data["target"]["name"] == "entire-field" || data["target"]["name"] == "all-pokemon":
		hit_range = HitRange.Entire_Field
	
	if data.has("meta") && data["meta"] != null:
		flags = 0
		var cat_name = data["meta"]["category"]["name"]
		if cat_name.find("damage") != -1:
			flags |= int(pow(2, Flags.Damage))
		if cat_name.find("ailment") != -1:
			flags |= int(pow(2, Flags.Ailment))
		if cat_name.find("heal") != -1:
			flags |= int(pow(2, Flags.Heal))
		if cat_name == "ohko":
			flags |= int(pow(2, Flags.OHKO))
		if cat_name == "field-effect":
			flags |= int(pow(2, Flags.Field_Effect))
		if cat_name == "whole_field_effect":
			flags |= int(pow(2, Flags.Whole_Field_Effect))
		if cat_name.find("lower") != -1:
			flags |= int(pow(2, Flags.Lower))
		if cat_name.find("raise") != -1:
			flags |= int(pow(2, Flags.Raise))
		if cat_name == "net-good-stats":
			if Utils.hits_user(hit_range):
				flags |= int(pow(2, Flags.Raise))
			if Utils.hits_target(hit_range):
				flags |= int(pow(2, Flags.Lower))
	
	load_effects(data)
	
	var effect_targeted = {}
	effect_targeted["name"] = "METargeted"
	effect_targeted["params"] = {}
	effect_targeted["params"]["accuracy"] = float(accuracy) / 100.0
	effect_targeted["params"]["guaranteed_hit"] = accuracy == 0
	effect_array.append(effect_targeted)
	var effect_damage = {}
	effect_damage["name"] = "MEDamage"
	effect_damage["params"] = {}
	effect_damage["params"]["base_damage"] = power
	effect_damage["params"]["type_id"] = type_id
	effect_damage["params"]["category"] = damage_class
	effect_array.append(effect_damage)
	
	description = get_en_description(data["flavor_text_entries"], "flavor_text")

func _save_to_json(data: Dictionary) -> void:
	data["name"] = move_name
	data["type"] = {}
	data["type"]["name"] = get_type().type_name.to_lower()
	data["damage_class"] = {}
	match damage_class:
		DamageClass.Status: data["damage_class"]["name"] = "status"
		DamageClass.Physical: data["damage_class"]["name"] = "physical"
		DamageClass.Special: data["damage_class"]["name"] = "special"
	if power > 0:
		data["power"] = power
	if accuracy > 0:
		data["accuracy"] = accuracy
	data["priority"] = priority
	data["pp"] = pp
	data["meta"] = {}
	data["meta"]["category"] = {}
	data["meta"]["category"]["name"] = ""
	if flags > 0:
		var cat = data["meta"]["category"]
		if int(pow(2, Flags.Damage)) & flags == int(pow(2, Flags.Damage)):
			cat["name"] = cat["name"] + "damage;"
		if int(pow(2, Flags.Ailment)) & flags == int(pow(2, Flags.Ailment)):
			cat["name"] = cat["name"] + "ailment;"
		if int(pow(2, Flags.Heal)) & flags == int(pow(2, Flags.Heal)):
			cat["name"] = cat["name"] + "heal;"
		if int(pow(2, Flags.OHKO)) & flags == int(pow(2, Flags.OHKO)):
			cat["name"] = "ohko"
		if int(pow(2, Flags.Field_Effect)) & flags == int(pow(2, Flags.Field_Effect)):
			cat["name"] = "field_effect"
		if int(pow(2, Flags.Whole_Field_Effect)) & flags == int(pow(2, Flags.Whole_Field_Effect)):
			cat["name"] = "whole_field_effect"
		if int(pow(2, Flags.Lower)) & flags == int(pow(2, Flags.Lower)):
			cat["name"] = cat["name"] + "lower;"
		if int(pow(2, Flags.Raise)) & flags == int(pow(2, Flags.Raise)):
			cat["name"] = cat["name"] + "raise;"
	
	data["target"] = {}
	var target = data["target"]
	if hit_range == HitRange.Opponent:
		target["name"] = "selected-pokemon"
	elif hit_range == HitRange.All_Opponents:
		target["name"] = "all-opponents"
	elif hit_range == HitRange.All:
		target["name"] = "all-other-pokemon"
	elif hit_range == HitRange.User:
		target["name"] = "user"
	elif hit_range == HitRange.Partner:
		target["name"] = "ally"
	elif hit_range == HitRange.User_or_Partner:
		target["name"] = "user-or-ally"
	elif hit_range == HitRange.User_Field:
		target["name"] = "users-field"
	elif hit_range == HitRange.Opponent_Field:
		target["name"] = "opponents-field"
	elif hit_range == HitRange.Entire_Field:
		target["name"] = "entire-field"
	
	data["stat_changes"] = []
	data["meta"]["ailment"] = {}
	data["meta"]["ailment"]["name"] = "none"
	data["meta"]["flinch_chance"] = 0
	save_effects(data)
	
	data["flavor_text_entries"] = []
	set_en_description(data["flavor_text_entries"], "flavor_text", description)

func load_effects(data: Dictionary) -> void:
	if data.has("move_effects"):
		effect_array = data["move_effects"]
	var effects
	if data["stat_changes"] != []:
		effects = Utils.add_node_if_not_exists(self, self, "Effects")
		if data["stat_changes"].size() > 0:
			var effect = Utils.add_typed_node_if_not_exists(EffectBoost, effects, self, "boosts")
			if data["meta"]["stat_chance"] == 0:
				effect.guaranteed = true
				effect.chance = 0
			else:
				effect.guaranteed = false
				effect.chance = data["meta"]["stat_chance"] / 100
			var flag_raise = int(pow(2, 10))
			if flags & flag_raise == flag_raise:
				effect.effected_pokemon = Effect.EffectedPokemon.User
			else:
				effect.effected_pokemon = Effect.EffectedPokemon.Target
			for stat_change in data["stat_changes"]:
				match stat_change["stat"]["name"]:
					"attack": effect.attack_boost = int(stat_change["change"])
					"defense": effect.defense_boost = int(stat_change["change"])
					"special-attack", "special_attack": effect.special_attack_boost = int(stat_change["change"])
					"special-defense", "special_defense": effect.special_defense_boost = int(stat_change["change"])
					"speed": effect.speed_boost = int(stat_change["change"])
	if data["meta"]["ailment"]["name"] != "none":
		effects = Utils.add_node_if_not_exists(self, self, "Effects")
		var effect
		match data["meta"]["ailment"]["name"]:
			"paralysis": effect = Utils.add_typed_node_if_not_exists(EffectParalysis, effects, self, "paralysis")
			"burn": effect = Utils.add_typed_node_if_not_exists(EffectBurn, effects, self, "burn")
			"poison": effect = Utils.add_typed_node_if_not_exists(EffectPoison, effects, self, "poison")
			"sleep": effect = Utils.add_typed_node_if_not_exists(EffectSleep, effects, self, "sleep")
			"freeze": effect = Utils.add_typed_node_if_not_exists(EffectFreeze, effects, self, "freeze")
			"confusion": effect = Utils.add_typed_node_if_not_exists(EffectConfusion, effects, self, "confusion")
		if effect != null:
			effect.effected_pokemon = Effect.EffectedPokemon.Target
			if data["effect_chance"] == 0:
				effect.guaranteed = true
				effect.chance = 0
			else:
				effect.guaranteed = false
				effect.chance = data["effect_chance"] / 100.0
	if data["meta"]["flinch_chance"] > 0:
		effects = Utils.add_node_if_not_exists(self, self, "Effects")
		var effect = Utils.add_typed_node_if_not_exists(EffectFlinch, effects, self, "flinch")
		effect.effected_pokemon = Effect.EffectedPokemon.Target
		if data["meta"]["flinch_chance"] == 100:
			effect.guaranteed = true
			effect.chance = 0
		else:
			effect.guaranteed = false
			effect.chance = data["meta"]["flinch_chance"] / 100

func save_effects(data: Dictionary) -> void:
	if has_node("Effects"):
		for effect in $Effects.get_children():
			effect._save_to_json(data)

func get_effects() -> Array:
	if effects != null:
		return effects.get_children()
	return []

func get_type() -> Node:
	return Utils.unpack(self, type, "Type")

func get_possible_target_positions(user_position: int) -> Array:
	var result = []
	if hit_range == HitRange.Opponent:
		result.append(user_position + 3)
	elif hit_range == HitRange.User:
		result.append(user_position)
	else:
		result.append(user_position + 3)
	return result

func get_target_positions(user_position: int, index: int) -> Array:
	var result = []
	var possible_target_positions = get_possible_target_positions(user_position)
	if has_target_choice():
		if index < possible_target_positions.size():
			result.append(possible_target_positions[index])
	else:
		result = possible_target_positions
	return result

func has_target_choice() -> bool:
	match hit_range:
		HitRange.Opponent, HitRange.User_or_Partner: return true
	return false
