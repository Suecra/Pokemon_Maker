extends "Importer.gd"

const Berry = preload("res://Source/Berry.gd")

func _get_name():
	return api_item["item"]["name"]

func _create_item():
	return Berry.new()

func _import_item(item):
	item.size = api_item["size"]
	item.smoothness = api_item["smoothness"]
	item.soil_dryness = api_item["soil_dryness"]
	match api_item["firmness"]["name"]:
		"very-soft": item.firmness = Berry.Firmness.Very_Soft
		"soft": item.firmness = Berry.Firmness.Soft
		"hard": item.firmness = Berry.Firmness.Hard
		"very-hard": item.firmness = Berry.Firmness.Very_Hard
		"super-hard": item.firmness = Berry.Firmness.Super_Hard
	item.grow_time = api_item["growth_time"]
	item.max_harvest = api_item["max_harvest"]
	item.flavor_spicy = api_item["flavors"][0]["potency"]
	item.flavor_dry = api_item["flavors"][1]["potency"]
	item.flavor_sweet = api_item["flavors"][2]["potency"]
	item.flavor_bitter = api_item["flavors"][3]["potency"]
	item.flavor_sour = api_item["flavors"][4]["potency"]
	item.natural_gift_power = api_item["natural_gift_power"]
	item.natural_gift_type = load(destination + "/Type/" + api_item["natural_gift_type"]["name"] + ".tscn")
	yield(get_tree().create_timer(0), "timeout")
