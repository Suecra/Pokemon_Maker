extends "res://Source/Data/GrowthRate.gd"

func _get_needed_exp(level: int) -> int:
	return int((4 * pow(level, 3)) / 5)

func _get_growth_rate_name() -> String:
	return "Fast"
