extends "res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var field: Reference
var fighters = []
var defeated := false

func add_fighter() -> Fighter:
	var fighter = Fighter.new()
	fighter.field = field
	fighter.team = self
	fighters.append(fighter)
	return fighter

func update_defeated() -> void:
	for fighter in fighters:
		if not fighter.fainted:
			return
	defeated = true
	field.update_defeated()

func _get_entity_relation(battle_entity: Reference) -> int:
	var type = battle_entity._get_type()
	match type:
		Type.FIGHTER:
			if battle_entity.team == self:
				return Role.ALLY
			else:
				return Role.OPPONENT
		Type.TEAM:
			if battle_entity == self:
				return Role.SELF
			else:
				return Role.OPPONENT
		Type.FIELD:
			if battle_entity == field:
				return Role.ALLY
			else:
				return Role.OPPONENT
	return Role.BATTLEFIELD

func _get_type() -> int:
	return Type.TEAM
