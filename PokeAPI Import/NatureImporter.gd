extends "Importer.gd"

const Nature = preload("res://Source/Data/Nature.gd")

func _create_item():
	return Nature.new()

func _import_item():
	item.nature_name = api_item["name"]
	item.inc_stat = get_stat("increased_stat")
	item.dec_stat = get_stat("decreased_stat")
	item.likes_flavor = get_flavor("likes_flavor")
	item.hates_flavor = get_flavor("hates_flavor")
	item.high_hp_attack_chance = api_item["move_battle_style_preferences"][0]["high_hp_preference"]
	item.low_hp_attack_chance = api_item["move_battle_style_preferences"][0]["low_hp_preference"]
	item.high_hp_defense_chance = api_item["move_battle_style_preferences"][1]["high_hp_preference"]
	item.low_hp_defense_chance = api_item["move_battle_style_preferences"][1]["low_hp_preference"]
	item.high_hp_support_chance = api_item["move_battle_style_preferences"][2]["high_hp_preference"]
	item.low_hp_support_chance = api_item["move_battle_style_preferences"][2]["low_hp_preference"]
	yield(get_tree().create_timer(0), "timeout")
	pass

func get_stat(property):
	if api_item[property] == null:
		return null
	var ret
	match api_item[property]["name"]:
		"attack": ret = Nature.Stat.Attack
		"defense": ret = Nature.Stat.Defense
		"special-attack": ret = Nature.Stat.Special_Attack
		"special-defense": ret = Nature.Stat.Special_Defense
		"speed": ret = Nature.Stat.Speed
	return ret

func get_flavor(property):
	if api_item[property] == null:
		return null
	var ret
	match api_item[property]["name"]:
		"spicy": ret = Nature.Flavor.Spicy
		"dry": ret = Nature.Flavor.Dry
		"sweet": ret = Nature.Flavor.Sweet
		"bitter": ret = Nature.Flavor.Bitter
		"sour": ret = Nature.Flavor.Sour
	return ret
