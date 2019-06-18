extends "Importer.gd"

const Move = preload("res://Source/Data/Move.gd")

var contest_effects = []
var moves = []
var api_items = []

func _create_item():
	return Move.new()

func _import_item(item):
	item.type = load("res://Source/Data/Type/" + api_item["type"]["name"] + ".tscn")
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
		item.contest_effect = load("res://Source/Data/Contest-Effect/contest_effect" + str(result["id"]) + ".tscn")
	item.description = get_en_description(api_item["flavor_text_entries"], "flavor_text")
	
	moves.append(item)
	api_items.append(api_item)
	yield(get_tree().create_timer(0), "timeout")

func _after_import():
	var item
	var scene
	var path 
	var directory_name = destination + "/" + folder_name
	for i in moves.size():
		item = api_items[i]
		if item["contest_combos"] != null:
			import_combos("normal", i)
			import_combos("super", i)
			
			scene = PackedScene.new()
			scene.pack(moves[i])
			path = directory_name + "/" + moves[i].name + ".tscn"
			ResourceSaver.save(path, scene)
			pass

func import_combos(contest: String, index: int):
	var item
	var move
	var node
	item = api_items[index]
	if item["contest_combos"][contest] != null:
		if item["contest_combos"][contest]["use_after"] != null:
			node = moves[index].get_node(contest)
			if node == null:
				node = Node.new()
				node.name = contest
				moves[index].add_child(node)
				node.owner = moves[index]
			for k in item["contest_combos"][contest]["use_after"].size():
				move = node.get_node(item["contest_combos"][contest]["use_after"][k]["name"])
				if move == null:
					move = Node.new()
					move.name = item["contest_combos"][contest]["use_after"][k]["name"]
					node.add_child(move)
					move.owner = moves[index]

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
	