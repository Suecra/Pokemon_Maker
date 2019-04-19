extends "Importer.gd"

const Move = preload("res://Source/Move.gd")

var contest_effects = []

func _create_item():
	return Move.new()

func _import_item(item):
	match api_item["damage_class"]["name"]:
		"status": item.damage_class = Move.DamageClass.Status
		"physical": item.damage_class = Move.DamageClass.Physical
		"special": item.damage_class = Move.DamageClass.Special
	item.power = api_item["power"]
	item.accuracy = api_item["accuracy"]
	item.priority = api_item["priority"]
	item.pp = api_item["pp"]
	
	if api_item["meta"] != null:
		item.flags = 0
		if api_item["meta"]["category"]["name"].find("damage") != -1:
			item.flags |= int(pow(2, 5))
		if api_item["meta"]["category"]["name"].find("ailment") != -1:
			item.flags |= int(pow(2, 6))
		if api_item["meta"]["category"]["name"].find("heal") != -1:
			item.flags |= int(pow(2, 7))
		if api_item["meta"]["category"]["name"] == "ohko":
			item.flags |= int(pow(2, 11))
		if api_item["meta"]["category"]["name"] == "field-effect":
			item.flags |= int(pow(2, 12))
		if api_item["meta"]["category"]["name"] == "whole_field_effect":
			item.flags |= int(pow(2, 13))
	
	if api_item["target"]["name"].find("selected-pokemon") != -1:
		item.hit_range = Move.HitRange.Opponent
	if api_item["target"]["name"] == "all-opponents" || api_item["target"]["name"] == "random-opponent":
		item.hit_range |= Move.HitRange.All_Opponents
	if api_item["target"]["name"] == "all-other-pokemon":
		item.hit_range |= Move.HitRange.All
	if api_item["target"]["name"] == "user" || api_item["target"]["name"] == "specific-move":
		item.hit_range |= Move.HitRange.User
	if api_item["target"]["name"] == "ally":
		item.hit_range |= Move.HitRange.Partner
	if api_item["target"]["name"] == "user-or-ally":
		item.hit_range |= Move.HitRange.User_or_Partner
	if api_item["target"]["name"] == "users-field" || api_item["target"]["name"] == "user-and-allies":
		item.hit_range |= Move.HitRange.User_Field
	if api_item["target"]["name"] == "opponents-field":
		item.hit_range |= Move.HitRange.Opponent_Field
	if api_item["target"]["name"] == "entire-field" || api_item["target"]["name"] == "all-pokemon":
		item.hit_range |= Move.HitRange.Entire_Field
	
	if api_item["contest_type"] != null:
		match api_item["contest_type"]["name"]:
			"cool": item.contest_type = Move.ContestType.Cool
			"beauty": item.contest_type = Move.ContestType.Beauty
			"cute": item.contest_type = Move.ContestType.Cute
			"smart": item.contest_type = Move.ContestType.Smart
			"tough": item.contest_type = Move.ContestType.Tough
	
	if api_item["contest_effect"] != null:
		yield(get_contest_effect(api_item["contest_effect"]["url"]), "completed")
		item.contest_effect = load("res://Source/Contest-Effect/contest_effect" + str(result["id"]) + ".tscn")
	item.description = get_en_description(api_item["flavor_text_entries"], "flavor_text")
	yield(get_tree().create_timer(0), "timeout")

func get_contest_effect(url):
	var id = int(url.substr(url.length() - 2, 1))
	for effect in contest_effects:
		if effect["id"] == id:
			result = effect
			yield(get_tree().create_timer(0), "timeout")
			return
	yield(do_request(api_item["contest_effect"]["url"], true), "completed")
	result = json.result
	contest_effects.append(result)
	