extends "Importer.gd"

const Type = preload("res://Source/Data/Type.gd")

func _create_item():
	return Type.new()

func _import_item(item):
	item.name = api_item["name"]
	item.very_effective = 0
	match api_item["name"]:
		"normal": item.id = Type.Types.NORMAL
		"fighting": item.id = Type.Types.FIGHTING
		"flying": item.id = Type.Types.FLYING
		"poison": item.id = Type.Types.POISON
		"ground": item.id = Type.Types.GROUND
		"rock": item.id = Type.Types.ROCK
		"bug": item.id = Type.Types.BUG
		"ghost": item.id = Type.Types.GHOST
		"steel": item.id = Type.Types.STEEL
		"fire": item.id = Type.Types.FIRE
		"water": item.id = Type.Types.WATER
		"grass": item.id = Type.Types.GRASS
		"electric": item.id = Type.Types.ELECTRIC
		"psychic": item.id = Type.Types.PSYCHIC
		"ice": item.id = Type.Types.ICE
		"dragon": item.id = Type.Types.DRAGON
		"dark": item.id = Type.Types.DARK
		"fairy": item.id = Type.Types.FAIRY
		"shadow": item.id = Type.Types.SHADOW
		"unknown": item.id = Type.Types.UNKNOWN
	
	var very_effective = get_types("double_damage_to")
	item.very_effective = very_effective
	var not_very_effective = get_types("half_damage_to")
	item.not_very_effective = not_very_effective
	var no_effect = get_types("no_damage_to")
	item.no_effect = no_effect
	var neutral = ~(very_effective | not_very_effective | no_effect)
	item.neutral = neutral
	yield(get_tree().create_timer(0), "timeout")

func get_types(property):
	var ret = 0
	for i in api_item["damage_relations"][property].size():
		match api_item["damage_relations"][property][i]["name"]:
			"normal": ret |= int(pow(2, 0))
			"fighting": ret |= int(pow(2, 1))
			"flying": ret |= int(pow(2, 2))
			"poison": ret |= int(pow(2, 3))
			"ground": ret |= int(pow(2, 4))
			"rock": ret |= int(pow(2, 5))
			"bug": ret |= int(pow(2, 6))
			"ghost": ret |= int(pow(2, 7))
			"steel": ret |= int(pow(2, 8))
			"fire": ret |= int(pow(2, 9))
			"water": ret |= int(pow(2, 10))
			"grass": ret |= int(pow(2, 11))
			"electric": ret |= int(pow(2, 12))
			"psychic": ret |= int(pow(2, 13))
			"ice": ret |= int(pow(2, 14))
			"dragon": ret |= int(pow(2, 15))
			"dark": ret |= int(pow(2, 16))
			"fairy": ret |= int(pow(2, 17))
			"shadow": ret |= int(pow(2, 18))
			"unknown": ret |= int(pow(2, 19))
	return ret
