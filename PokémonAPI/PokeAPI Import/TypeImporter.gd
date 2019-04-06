extends "Importer.gd"

const Type = preload("res://Source/Type.gd")

func _create_item():
	return Type.new()

func _import_item(item):
	item.name = api_item["name"]
	item.very_effective = 0
	match api_item["name"]:
		"normal": item.id = Type.NORMAL
		"fighting": item.id = Type.FIGHTING
		"flying": item.id = Type.FLYING
		"poison": item.id = Type.POISON
		"ground": item.id = Type.GROUND
		"rock": item.id = Type.ROCK
		"bug": item.id = Type.BUG
		"ghost": item.id = Type.GHOST
		"steel": item.id = Type.STEEL
		"fire": item.id = Type.FIRE
		"water": item.id = Type.WATER
		"grass": item.id = Type.GRASS
		"electric": item.id = Type.ELECTRIC
		"psychic": item.id = Type.PSYCHIC
		"ice": item.id = Type.ICE
		"dragon": item.id = Type.DRAGON
		"dark": item.id = Type.DARK
		"fairy": item.id = Type.FAIRY
		"shadow": item.id = Type.SHADOW
		"unknown": item.id = Type.UNKNOWN
	
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
			"normal": ret |= 1
			"fighting": ret |= 2
			"flying": ret |= 4
			"poison": ret |= 8
			"ground": ret |= 16
			"rock": ret |= 32
			"bug": ret |= 64
			"ghost": ret |= 128
			"steel": ret |= 256
			"fire": ret |= 512
			"water": ret |= 1024
			"grass": ret |= 2048
			"electric": ret |= 4096
			"psychic": ret |= 8192
			"ice": ret |= 16384
			"dragon": ret |= 32768
			"dark": ret |= 65536
			"fairy": ret |= 131072
			"shadow": ret |= 262144
			"unknown": ret |= 524288
	return ret
