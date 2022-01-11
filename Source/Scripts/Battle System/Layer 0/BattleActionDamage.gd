extends "res://Source/Scripts/Battle System/Layer 0/BattleAction.gd"

var hp: int

func _init(fighter: Fighter, hp: int) -> void:
	self.fighter = fighter
	self.hp = hp

func _execute() -> void:
	fighter.damage(hp)
