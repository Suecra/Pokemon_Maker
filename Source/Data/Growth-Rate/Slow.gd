extends "res://Source/Data/GrowthRate.gd"

func _get_needed_exp(level: int) -> int:
	return int((5 * pow(level, 3)) / 4)

func  _get_growth_rate_name() -> String:
	return "Slow"
