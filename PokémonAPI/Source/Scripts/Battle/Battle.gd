extends Node

const Utils = preload("res://Source/Scripts/Utils.gd")
const Trainer = preload("res://Source/Scripts/Battle/Trainer.gd")
const Field = preload("res://Source/Scripts/Battle/Field.gd")
const Battlefield = preload("res://Source/Scripts/Battle/Battlefield.gd")
const HalfTurn = preload("res://Source/Scripts/Battle/HalfTurn.gd")
const BattleAction = preload("res://Source/Scripts/Battle/BattleAction.gd")

export(int) var current_turn
var ally_field: Field
var opponent_field: Field
var battlefield: Battlefield

func add_ally_trainer(trainer):
	get_node("Trainers").add_child(trainer)
	ally_field.trainers.append(trainer)
	trainer.field = ally_field
	trainer.battle = self
	trainer.init_battle()

func add_opponent_trainer(trainer):
	get_node("Trainers").add_child(trainer)
	opponent_field.trainers.append(trainer)
	trainer.field = opponent_field
	trainer.battle = self
	trainer.init_battle()

func is_battle_ended():
	var trainers = $Trainers.get_children()
	var count = 0
	for t in trainers:
		if t.has_pokemon_left():
			count = count + 1
	return count <= 1

func start():
	print("Battle starts")
	current_turn = 0
	yield(first_turn()._start(), "completed");
	while not is_battle_ended():
		yield(next_turn()._start(), "completed");
		current_turn += 1
	print("Battle ended")

func next_turn():
	var Turn = load("res://Source/Scripts/Battle/Turn.gd")
	var turn = Turn.new()
	init_turn(turn)
	return turn

func first_turn():
	var FirstTurn = load("res://Source/Scripts/Battle/FirstTurn.gd")
	var first_turn = FirstTurn.new()
	init_turn(first_turn)
	return first_turn

func init_turn(turn):
	turn.battle = self
	var trainers = $Trainers.get_children()
	for t in trainers:
		turn.trainers.append(t)
	var prev_turns = $Turns.get_children()
	if prev_turns.size() > 0:
		turn.prev_turn = prev_turns[prev_turns.size() - 1]
	turn.owner = $Turns
	$Turns.add_child(turn)

func _ready():
	Utils.add_node_if_not_exists(self, self, "Trainers")
	ally_field = Field.new()
	add_child(ally_field)
	opponent_field = Field.new()
	add_child(battlefield)
	Utils.add_node_if_not_exists(self, self, "Turns")
	battlefield = $Battlefield