extends "res://Source/Data/DamageMove.gd"

func _get_attack():
	return user.special_attack

func _get_defense(target: int):
	return targets[target].special_defense