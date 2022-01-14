extends Reference

enum Type {FIGHTER, TEAM, FIELD, BATTLEFIELD}
enum Role {SELF, ALLY, OPPONENT, BATTLEFIELD}

func _get_entity_relation(battle_entity: Reference) -> int:
	return Role.BATTLEFIELD

func _get_type() -> int:
	return -1
