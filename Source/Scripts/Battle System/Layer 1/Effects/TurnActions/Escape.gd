extends "res://Source/Scripts/Battle System/Layer 1/Effects/TurnAction.gd"

func init() -> void:
	priority = 6
	set_name("Escape")

func execute() -> void:
	battle.battle_l0.state = 3
	battle.add_effect(battle.battle_l0.battlefield, "Aborted")
