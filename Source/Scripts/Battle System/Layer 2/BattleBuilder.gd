extends Reference

class_name BattleBuilder

const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const BattleL1 = preload("res://Source/Scripts/Battle System/Layer 1/Battle.gd")
const BattleL2 = preload("res://Source/Scripts/Battle System/Layer 2/Battle.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
const Trainer = preload("res://Source/Scripts/Battle System/Layer 2/Trainer.gd")
const Team = preload("res://Source/Scripts/Battle System/Layer 2/Team.gd")
const SimpleTrainerController = preload("res://Source/Scripts/Battle System/Layer 2/TrainerControllers/SimpleController.gd")
const Pokemon = preload("res://Source/Scripts/Game/Pokemon.gd")

static func build_sample_battle(parent: Node) -> BattleL2:
	var b0 = BattleL0.new(1)
	var b1 = BattleL1.new()
	var b2 = BattleL2.new()
	
	var field1 = b0.battlefield.add_field()
	var field2 = b0.battlefield.add_field()
	var team1 = field1.add_team()
	var team2 = field2.add_team()
	var fighter1 = team1.add_fighter()
	var fighter2 = team2.add_fighter()
	
	var fieldl2_1 = b2.add_field()
	var fieldl2_2 = b2.add_field()
	var trainer1 = fieldl2_1.add_trainer()
	var trainer2 = fieldl2_2.add_trainer()
	var pokemon1 = trainer1.team.add_pokemon()
	var pokemon2 = trainer2.team.add_pokemon()
	
	fighter1.name = "bidoof1"
	fighter2.name = "bidoof2"
	team1.name = "Team1"
	team2.name = "Team2"
	pokemon1.fighter = fighter1
	pokemon2.fighter = fighter2
	
	var p1 = Pokemon.new()
	parent.add_child(p1)
	p1.owner = parent
	p1.species = "bidoof"
	p1.level = 5
	p1.nature = "hardy"
	p1.add_move("tackle")
	var p2 = Pokemon.new()
	parent.add_child(p2)
	p2.owner = parent
	p2.species = "bidoof"
	p2.level = 5
	p2.nature = "hardy"
	p2.add_move("tackle")
	
	pokemon1.pokemon = p1
	pokemon2.pokemon = p2
	trainer1.team.team_l0 = team1
	trainer2.team.team_l0 = team2
	trainer1.controller = SimpleTrainerController.new()
	trainer2.controller = SimpleTrainerController.new()
	fieldl2_1.field_l0 = field1
	fieldl2_2.field_l0 = field2
	
	b1.battle_l0 = b0
	b2.battle_l1 = b1
	
	return b2
