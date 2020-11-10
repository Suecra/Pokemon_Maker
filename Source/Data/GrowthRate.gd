extends "PMDataObject.gd"

func _load_from_json(data: Dictionary) -> void:
	print("Loading GrowthRate from json is not supported!")

func _save_to_json(data: Dictionary) -> void:
	data["name"] = _get_growth_rate_name()

func _get_needed_exp(level: int) -> int:
	return 0

func _get_growth_rate_name() -> String:
	return ""
