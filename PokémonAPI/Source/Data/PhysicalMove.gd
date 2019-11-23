extends "res://Source/Data/DamageMove.gd"

func _get_attack():
	return user.current_attack

func _get_defense(target):
	return target.current_defense
