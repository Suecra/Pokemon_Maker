extends "res://Source/Scripts/Battle System/Layer 0/BattleAction.gd"

var position: int

func _init(fighter: Fighter, position: int) -> void:
	self.fighter = fighter
	self.position = position

func _execute() -> void:
	fighter.position = position
