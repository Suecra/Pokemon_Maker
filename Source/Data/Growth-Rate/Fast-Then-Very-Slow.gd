extends "res://Source/Data/GrowthRate.gd"

func _get_needed_exp(level: int) -> int:
	if level >= 36:
		return int(pow(level, 3) * ((32 + int(level / 2)) / 50))
	if level > 15:
		return int(pow(level, 3) * ((14 + level) / 50))
	return int(pow(level, 3) * ((24 + int((level + 1) / 3)) / 50))

func _get_growth_rate_name() -> String:
	return "Fast-Then-Very-Slow"
