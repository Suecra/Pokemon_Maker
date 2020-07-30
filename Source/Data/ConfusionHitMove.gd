extends "res://Source/Data/PhysicalMove.gd"

func _get_damage_multiplier(target: Node) -> float:
	return 1.0

func _is_STAB() -> bool:
	return false

func _is_critical_hit() -> bool:
	return false
