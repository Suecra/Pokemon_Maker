extends Reference

const Trainer = preload("res://Source/Scripts/Battle System/Layer 2/Trainer.gd")
const Team = preload("res://Source/Scripts/Battle System/Layer 2/Team.gd")
const FieldL0 = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")

var battle: Reference
var field_l0: FieldL0
var trainers: Array

func add_trainer() -> Trainer:
	var trainer = Trainer.new()
	trainer.team = Team.new()
	trainer.team.battle = battle
	trainer.team.field = self
	trainer.team.trainer = trainer
	trainer.field = self
	trainer.battle = battle
	trainers.append(trainer)
	return trainer

func init_battle() -> void:
	battle.battle_l1.add_effect(field_l0, "FieldFunctions")
	for t in trainers:
		t.init_battle()

func request_action() -> void:
	for t in trainers:
		for p in t.team.pokemon:
			t.request_action(p)
