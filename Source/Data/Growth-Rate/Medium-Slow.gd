extends "res://Source/Data/GrowthRate.gd"

func _get_needed_exp(level: int) -> int:
	return int((6 / 5) * pow(level, 3) - 15 * pow(level, 2) + 100 * level - 140)

func _get_growth_rate_name() -> String:
	return "Medium-Slow"
