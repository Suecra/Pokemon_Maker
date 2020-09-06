extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionBattle

const Battle = preload("res://Scenes/BattleBase.tscn")

var battle: Node
var trainer1: Node
var trainer2: Node
var player_won: bool

func execute() -> void:
	trainer1.pokemon_party.full_heal_all()
	trainer2.pokemon_party.full_heal_all()
	battle = Battle.instance()
	event.map.get_node("BattleLayer").add_child(battle)
	battle.add_ally_trainer(trainer1)
	battle.add_opponent_trainer(trainer2)
	battle.connect("ended", self, "finish")
	yield(battle.start(), "completed")
	player_won = battle.player_won
	event.map.get_node("BattleLayer").remove_child(battle)

func won() -> EventAction:
	return event.add_action(EventActionCondition.new(self, "player_won"))

func _init(trainer1, trainer2) -> void:
	self.trainer1 = trainer1
	self.trainer2 = trainer2
