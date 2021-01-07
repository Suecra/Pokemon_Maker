extends "res://Source/Data/PMDataObject.gd"

class_name LearnableMove

export(String) var move_name
export(int) var level
export(bool) var egg
export(bool) var tm

func _load_from_json(data: Dictionary) -> void:
	name = data["move"]["name"]
	var count = data["version_group_details"].size()
	get_move_data(data["version_group_details"][count - 1])

func _save_to_json(data: Dictionary) -> void:
	data["move"] = {}
	data["move"]["name"] = name
	data["version_group_details"] = []
	data["version_group_details"].append({})
	set_move_data(data["version_group_details"][0])

func get_move_data(data: Dictionary) -> void:
	move_name = name
	match data["move_learn_method"]["name"]:
		"egg": egg = true
		"machine": tm = true
		"level-up": level = int(data["level_learned_at"])

func set_move_data(data: Dictionary) -> void:
	data["move_learn_method"] = {}
	if egg:
		data["move_learn_method"]["name"] = "egg"
	elif tm:
		data["move_learn_method"]["name"] = "machine"
	else:
		data["move_learn_method"]["name"] = "level-up"
		data["level_learned_at"] = level
