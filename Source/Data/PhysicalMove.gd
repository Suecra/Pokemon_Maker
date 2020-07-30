extends "res://Source/Data/DamageMove.gd"

func _get_attack() -> int:
	return user.current_attack

func _get_defense(target: Node) -> int:
	return target.current_defense
