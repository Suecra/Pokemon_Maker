extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionBattle

const Battle = preload("res://Scenes/BattleBase.tscn")

var battle
var trainer1
var trainer2

func execute():
	trainer1.pokemon_party.full_heal_all()
	trainer2.pokemon_party.full_heal_all()
	battle = Battle.instance()
	event.map.get_node("BattleLayer").add_child(battle)
	battle.add_ally_trainer(trainer1)
	battle.add_opponent_trainer(trainer2)
	battle.connect("ended", self, "finish")
	yield(battle.start(), "completed")
	event.map.get_node("BattleLayer").remove_child(battle)

func _init(trainer1, trainer2):
	self.trainer1 = trainer1
	self.trainer2 = trainer2
