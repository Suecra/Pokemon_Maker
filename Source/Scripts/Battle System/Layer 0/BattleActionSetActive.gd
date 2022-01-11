extends "res://Source/Scripts/Battle System/Layer 0/BattleAction.gd"

var active: bool

func _init(fighter: Fighter, active: bool) -> void:
	self.fighter = fighter
	self.active = active

func _execute() -> void:
	fighter.active = active
