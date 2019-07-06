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

func add_opponent_trainer(trainer):
	get_node("Trainers").add_child(trainer)
	opponent_field.trainers.append(trainer)
	trainer.field = opponent_field

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
	while not is_battle_ended():
		yield(next_turn().start(), "completed");
		current_turn += 1

func next_turn():
	var Turn = load("res://Source/Scripts/Battle/Turn.gd")
	var turn = Turn.new()
	turn.battle = self
	var trainers = $Trainers.get_children()
	for t in trainers:
		turn.trainers.append(t)
	var prev_turns = $Turns.get_children()
	if prev_turns.size() > 0:
		turn.prev_turn = prev_turns[prev_turns.size() - 1]
	turn.owner = $Turns
	$Turns.add_child(turn)
	return turn

func _ready():
	Utils.add_node_if_not_exists(self, self, "Trainers")
	ally_field = Field.new()
	add_child(ally_field)
	opponent_field = Field.new()
	add_child(battlefield)
	Utils.add_node_if_not_exists(self, self, "Turns")
	battlefield = $Battlefield