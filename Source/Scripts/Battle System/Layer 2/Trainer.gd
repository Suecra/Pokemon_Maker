extends Reference

const Team = preload("res://Source/Scripts/Battle System/Layer 2/Team.gd")

var battle: Reference
var field: Reference
var team: Team
var controller: Reference

func init_battle() -> void:
	team.init_battle()

func request_action(pokemon) -> void:
	controller._request_action(pokemon)
