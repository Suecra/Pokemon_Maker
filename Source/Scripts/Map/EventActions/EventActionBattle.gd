extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionBattle

const BattleScene = preload("res://Scenes/BattleBase.tscn")
const Battle = preload("res://Source/Scripts/Battle/Battle.gd")

var battle: Node
var trainer1: Node
var trainer2: Node
var player_won: bool

func execute() -> void:
	battle = BattleScene.instance()
	Global.map.get_node("BattleLayer").add_child(battle)
	battle.add_ally_trainer(trainer1)
	battle.add_opponent_trainer(trainer2)
	battle.connect("ended", self, "finish")
	yield(battle.start(), "completed")
	player_won = battle.result == Battle.BattleResult.PlayerWon
	Global.map.get_node("BattleLayer").remove_child(battle)

func won() -> EventAction:
	return event.add_action(EventActionCondition.new(self, "player_won"))

func _init(trainer1, trainer2) -> void:
	self.trainer1 = trainer1
	self.trainer2 = trainer2
