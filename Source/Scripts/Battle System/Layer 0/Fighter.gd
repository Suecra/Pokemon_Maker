extends "res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd"

var field: Reference
var team: Reference
var hp: int
var position: int setget set_position
var active: bool setget set_active
var fainted: bool setget set_fainted

func set_active(value: bool) -> void:
	if value:
		check_position(position)
	active = value

func set_position(value: int) -> void:
	check_position(value)
	position = value

func set_fainted(value: bool) -> void:
	fainted = value
	if fainted:
		team.update_defeated()

func check_position(position: int) -> void:
	assert(not field.is_position_out_of_bounds(position), "Position " + str(position) + " is out of bounds!")
	assert(not field.is_position_blocked(position), "Position " + str(position) + " is blocked!")

func damage(hp: int) -> void:
	self.hp = max(0, self.hp - hp)

func heal(hp: int) -> void:
	self.hp += hp

func _get_entity_relation(battle_entity: Reference) -> int:
	var type = battle_entity._get_type()
	match type:
		Type.FIGHTER:
			if battle_entity.field == field:
				return Role.ALLY
			else:
				return Role.OPPONENT
		Type.TEAM:
			if battle_entity.team == team:
				return Role.ALLY_TEAM
			else:
				return Role.OPPONENT_TEAM
		Type.FIELD:
			if battle_entity == field:
				return Role.ALLY_FIELD
			else:
				return Role.OPPONENT_FIELD
	return Role.BATTLEFIELD

func _get_type() -> int:
	return Type.FIGHTER
