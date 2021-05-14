extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionBattle

const BattleScene = preload("res://Scenes/BattleBase.tscn")
const Battle = preload("res://Source/Scripts/Battle/Battle.gd")

var battle: Node
var trainer1: Node
var trainer2: Node
var type: int
var player_won: bool

func execute() -> void:
	battle = BattleScene.instance()
	battle.battle_type = type
	Global.battle_layer.add_child(battle)
	battle.add_ally_trainer(trainer1)
	battle.add_opponent_trainer(trainer2)
	battle.connect("ended", self, "finish")
	yield(battle.start(), "completed")
	player_won = battle.result == Battle.BattleResult.PlayerWon
	Global.battle_layer.remove_child(battle)

func won() -> EventAction:
	return event.add_action(EventActionCondition.new(self, "player_won"))

func _init(trainer1: Node, trainer2: Node, type: int) -> void:
	self.trainer1 = trainer1
	self.trainer2 = trainer2
	self.type = type
