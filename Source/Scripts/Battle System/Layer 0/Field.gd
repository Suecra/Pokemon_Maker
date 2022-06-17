extends "res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

var size: int
var defeated := false
var teams = []

func add_team() -> Reference:
	var team = load("res://Source/Scripts/Battle System/Layer 0/Team.gd").new()
	team.field = self
	teams.append(team)
	return team

func get_fighter_at_position(position: int) -> Fighter:
	for team in teams:
		for fighter in team.fighters:
			if !fighter.fainted && fighter.active && fighter.position == position:
				return fighter
	return null

func is_position_blocked(position: int) -> bool:
	var fighter = get_fighter_at_position(position)
	return fighter != null

func is_position_out_of_bounds(position: int) -> bool:
	return position < 0 || position >= size

func update_defeated() -> void:
	for team in teams:
		if not team.defeated:
			return
	defeated = true

func _get_entity_relation(battle_entity: Reference) -> int:
	var type = battle_entity._get_type()
	match type:
		Type.FIGHTER, Type.TEAM:
			if battle_entity.field == self:
				return L1Consts.Role.ALLY
			else:
				return L1Consts.Role.OPPONENT
		Type.FIELD:
			if battle_entity == self:
				return L1Consts.Role.SELF
			else:
				return L1Consts.Role.OPPONENT
	return L1Consts.Role.BATTLEFIELD

func _get_type() -> int:
	return Type.FIELD
