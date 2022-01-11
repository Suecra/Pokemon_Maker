extends "res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd"

const Team = preload("res://Source/Scripts/Battle System/Layer 0/Team.gd")

var size: int
var defeated := false
var teams = []

func add_team() -> Team:
	var team = Team.new()
	team.field = self
	teams.append(team)
	return team

func is_position_blocked(position: int) -> bool:
	for team in teams:
		for fighter in team.fighters:
			if !fighter.fainted && fighter.active && fighter.position == position:
				return true
	return false

func is_position_out_of_bounds(position: int) -> bool:
	return position >= size

func update_defeated() -> void:
	for team in teams:
		if not team.defeated:
			return
	defeated = true

func _get_entity_relation(battle_entity: Reference) -> int:
	var type = battle_entity._get_type()
	match type:
		Type.FIGHTER:
			if battle_entity.field == self:
				return Role.ALLY
			else:
				return Role.OPPONENT
		Type.TEAM:
			if battle_entity.field == self:
				return Role.ALLY_TEAM
			else:
				return Role.OPPONENT_TEAM
		Type.FIELD:
			if battle_entity == self:
				return Role.ALLY_FIELD
			else:
				return Role.OPPONENT_FIELD
	return Role.BATTLEFIELD

func _get_type() -> int:
	return Type.FIELD
