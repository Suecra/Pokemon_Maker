extends Reference

const Team = preload("res://Source/Scripts/Battle System/Layer 2/Team.gd")

var battle: Reference
var team: Team

func get_field() -> Reference:
	return team.team_l0.field

func init_battle() -> void:
	battle.battle_l1.add_effect(get_field(), "FieldFunctions")
	team.init_battle()
