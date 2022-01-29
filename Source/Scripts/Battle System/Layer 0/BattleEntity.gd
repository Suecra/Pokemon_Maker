extends Reference

enum Type {FIGHTER, TEAM, FIELD, BATTLEFIELD}

func _get_entity_relation(battle_entity: Reference) -> int:
	return L1Consts.Role.BATTLEFIELD

func _get_type() -> int:
	return -1
