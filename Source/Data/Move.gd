extends "res://Source/Data/PMDataObject.gd"

class_name Move

enum DamageClass {Physical, Special, Status}
enum Flags {Contact, Protect, Mirrorable, Kings_Rock, Sky_Battle, Damage, Ailment, Heal, Punch, Lower, Raise, OHKO, Field_Effect, Whole_Field_Effect}
enum HitRange {Opponent, All_Opponents, All, User, Partner, User_or_Partner, User_Field, Opponent_Field, Entire_Field}
enum ContestType {Cool, Beauty, Cute, Smart, Tough}

export(String) var move_name
export(PackedScene) var type
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

onready var effects = $Effects

func _load_from_json(data: Dictionary) -> void:
	move_name = data["name"]
	name = move_name
	type = load(Consts.TYPE_PATH + data["type"]["name"] + ".tscn")
	match data["damage_class"]["name"]:
		"status": damage_class = DamageClass.Status
		"physical": damage_class = DamageClass.Physical
		"special": damage_class = DamageClass.Special
	if data["power"] != null:
		power = int(data["power"])
	if data["accuracy"] != null:
		accuracy = int(data["accuracy"])
	if data["priority"] != null:
		priority = int(data["priority"])
	if data["pp"] != null:
		pp = int(data["pp"])
	
	if data["meta"] != null:
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
		if cat_name == "damage+lower":
			flags |= int(pow(2, Flags.Lower))
		if cat_name == "damage+raise":
			flags |= int(pow(2, Flags.Raise))
	
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
	
	load_effects(data)
	
	#if data["contest_type"] != null:
	#	match data["contest_type"]["name"]:
	#		"cool": contest_type = ContestType.Cool
	#		"beauty": contest_type = ContestType.Beauty
	#		"cute": contest_type = ContestType.Cute
	#		"smart": contest_type = ContestType.Smart
	#		"tough": contest_type = ContestType.Tough
	
	#if data["contest_effect"] != null:
		#contest_effect = load("res://Source/Data/Contest-Effect/contest_effect" + str(result["id"]) + ".tscn")
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
	if flags > 0:
		data["meta"]["category"] = {}
		var cat = data["meta"]["category"]
		cat["name"] = ""
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
			cat["name"] = "damage+lower"
		if int(pow(2, Flags.Raise)) & flags == int(pow(2, Flags.Raise)):
			cat["name"] = "damage+raise"
	
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
	#TODO: Save Effects
	
	data["flavor_text_entries"] = []
	set_en_description(data["flavor_text_entries"], "flavor_text", description)

func load_effects(data: Dictionary) -> void:
	var effects
	if data["stat_changes"] != null || data["meta"]["ailment"]["name"] != "none":
		effects = Utils.add_node_if_not_exists(self, self, "Effects")
		if data["stat_changes"].size() > 0:
			var effect = Utils.add_typed_node_if_not_exists(EffectBoost, effects, self, "Boosts")
			if data["meta"]["stat_chance"] == 0:
				effect.guaranteed = true
			else:
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
					"special-attack": effect.special_attack_boost = int(stat_change["change"])
					"special-denfense": effect.special_defense_boost = int(stat_change["change"])
					"speed": effect.speed_boost = int(stat_change["change"])
		if data["meta"]["ailment"]["name"] != "none":
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
				if data["effect_chance"] == null:
					effect.guaranteed = true
					effect.chance = 0
				else:
					effect.guaranteed = false
					effect.chance = data["effect_chance"] / 100
		if data["meta"]["flinch_chance"] > 0:
			var effect = Utils.add_typed_node_if_not_exists(EffectFlinch, effects, self, "flinch")
			effect.effected_pokemon = Effect.EffectedPokemon.Target
			if data["meta"]["flinch_chance"] == 100:
				effect.guaranteed = true
				effect.chance = 0
			else:
				effect.guaranteed = false
				effect.chance = data["meta"]["flinch_chance"] / 100

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
