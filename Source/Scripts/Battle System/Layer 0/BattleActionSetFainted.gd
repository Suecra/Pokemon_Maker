extends "res://Source/Scripts/Battle System/Layer 0/BattleAction.gd"

var fainted: bool

func _init(fighter: Fighter, fainted: bool) -> void:
	self.fighter = fighter
	self.fainted = fainted

func _execute() -> void:
	fighter.fainted = fainted
