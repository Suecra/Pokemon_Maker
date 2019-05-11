extends "res://Source/Data/GenderChance.gd"

func _generate_gender():
	if Utils.trigger(0.5):
		return Gender.Male
	return Gender.Female