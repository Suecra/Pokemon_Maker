extends "res://Source/Data/GrowthRate.gd"

func _get_needed_exp(level: int) -> int:
	if level >= 98:
		return int(pow(level, 3) * ((160 - level) / 100))
	if level >= 68:
		return int(pow(level, 3) * (int((1911 - level * 10) / 3) / 500))
	if level >= 50:
		return int(pow(level, 3) * ((150 - level) / 100))
	if level > 1:
		return int(pow(level, 3) * ((100 - level) / 50))
	return 0

func  _get_growth_rate_name() -> String:
	return "Slow-Then-Very-Fast"
