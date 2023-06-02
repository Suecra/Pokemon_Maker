extends "res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd"

const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")

var fields = []
var size: int

func add_field() -> Field:
	var field = Field.new()
	fields.append(field)
	field.size = size
	return field

func _get_entity_relation(battle_entity: Reference) -> int:
	if battle_entity == self:
		return L1Consts.Role.OWNER
	return L1Consts.Role.BATTLEFIELD

func _get_type() -> int:
	return Type.BATTLEFIELD
