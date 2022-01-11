extends Reference

enum Type {FIGHTER, TEAM, FIELD, BATTLEFIELD}
enum Role {ALLY, OPPONENT, ALLY_FIELD, OPPONENT_FIELD, ALLY_TEAM, OPPONENT_TEAM}

func _get_entity_relation(battle_entity: Reference) -> int:
	return Role.BATTLEFIELD

func _get_type() -> int:
	return -1
