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
		active = false
		team.update_defeated()

func check_position(position: int) -> void:
	assert(not field.is_position_out_of_bounds(position), "Position " + str(position) + " is out of bounds!")
	assert(not field.is_position_blocked(position), "Position " + str(position) + " is blocked!")

func damage(hp: int) -> void:
	self.hp = max(0, self.hp - max(0, hp))

func heal(hp: int) -> void:
	self.hp += max(0, hp)

func _get_entity_relation(battle_entity: Reference) -> int:
	var type = battle_entity._get_type()
	match type:
		Type.FIGHTER:
			if battle_entity == self:
				return L1Consts.Role.OWNER
			elif battle_entity.field == field:
				return L1Consts.Role.ALLY
			else:
				return L1Consts.Role.OPPONENT
		Type.TEAM:
			if battle_entity == team:
				return L1Consts.Role.ALLY
			else:
				return L1Consts.Role.OPPONENT
		Type.FIELD:
			if battle_entity == field:
				return L1Consts.Role.ALLY
			else:
				return L1Consts.Role.OPPONENT
	return L1Consts.Role.BATTLEFIELD

func _get_type() -> int:
	return Type.FIGHTER
