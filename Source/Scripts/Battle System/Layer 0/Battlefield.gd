extends "res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd"

const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")

var fields = []

func add_field() -> Field:
	var field = Field.new()
	fields.append(field)
	return field

func _get_entity_relation(battle_entity: Reference) -> int:
	return Role.BATTLEFIELD

func _get_type() -> int:
	return Type.BATTLEFIELD
