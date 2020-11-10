extends "res://Source/Data/GenderChance.gd"

func _generate_gender() -> int:
	if Utils.trigger(0.875):
		return Gender.Female
	return Gender.Male

func _get_gender_rate() -> int:
	return 7
