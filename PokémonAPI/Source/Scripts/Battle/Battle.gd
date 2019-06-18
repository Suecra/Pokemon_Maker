extends Node

enum BattleEvent {EVENT_BEFORE_MOVE, EVENT_AFTER_MOVE, EVENT_SWITCH_OUT, EVENT_SWITCH_IN, EVENT_BEFORE_TURN, EVENT_AFTER_TURN}

const Utils = preload("res://Source/Scripts/Utils.gd")
const Trainer = preload("res://Source/Scripts/Battle/Trainer.gd")
const Field = preload("res://Source/Scripts/Battle/Field.gd")
const HalfTurn = preload("res://Source/Scripts/Battle/HalfTurn.gd")
const BattleAction = preload("res://Source/Scripts/Battle/BattleAction.gd")

export(int) var current_turn
var ally_field: Field
var opponent_field: Field

func add_ally_trainer(trainer):
	get_node("Trainers").add_child(trainer)
	ally_field.trainers.append(trainer)

func add_opponent_trainer(trainer):
	get_node("Trainers").add_child(trainer)
	opponent_field.trainers.append(trainer)

func start():
	pass

func _ready():
	Utils.add_node_if_not_exists(self, self, "Trainers")
	ally_field = Field.new()
	add_child(ally_field)
	opponent_field = Field.new()
	add_child(opponent_field)
	Utils.add_node_if_not_exists(self, self, "Turns")