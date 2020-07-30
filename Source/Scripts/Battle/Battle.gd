extends Node

const Trainer = preload("res://Source/Scripts/Battle/Trainer.gd")
const Field = preload("res://Source/Scripts/Battle/Field.gd")
const Battlefield = preload("res://Source/Scripts/Battle/Battlefield.gd")
const HalfTurn = preload("res://Source/Scripts/Battle/HalfTurn.gd")
const BattleAnimation = preload("res://Source/Scripts/Battle/BattleAnimation.gd")
const BattleAnimationMessage = preload("res://Source/Scripts/Battle/Animations/BattleAnimationMessage.gd")

onready var battlefield := $Battlefield

export(int) var current_turn_nr
export(Vector2) var ally_position
export(Vector2) var opponent_position
var current_turn: Node
var ally_field: Field
var opponent_field: Field
var trainers := []
var player_won := false

signal ended

func add_ally_trainer(trainer: Trainer) -> void:
	trainers.append(trainer)
	ally_field.trainers.append(trainer)
	trainer.field = ally_field
	trainer.battle = self

func add_opponent_trainer(trainer: Trainer) -> void:
	trainers.append(trainer)
	opponent_field.trainers.append(trainer)
	trainer.field = opponent_field
	trainer.battle = self

func is_battle_ended() -> bool:
	var count = 0
	for trainer in trainers:
		if trainer.resigned:
			if trainer.field == opponent_field:
				player_won = true
			return true
		if trainer.has_pokemon_left():
			count += 1
		elif trainer.field == opponent_field:
			player_won = true
	return count <= 1

func start() -> void:
	for trainer in trainers:
		trainer.init_battle()
	current_turn_nr = 0
	current_turn = first_turn()
	yield(current_turn._start(), "completed")
	current_turn_nr = 1
	while not is_battle_ended():
		current_turn = next_turn()
		yield(current_turn._start(), "completed")
		current_turn_nr += 1
	$MessageBox.close()
	emit_signal("ended")

func start_async() -> void:
	for trainer in trainers:
		trainer.init_battle()
	current_turn_nr = 0
	current_turn = first_turn()
	current_turn.connect("turn_end", self, "turn_end")
	current_turn._start_async()
	turn_end()

func turn_end() -> void:
	current_turn_nr += 1
	current_turn.disconnect("turn_end", self, "turn_end")
	if not is_battle_ended():
		current_turn = next_turn()
		current_turn.connect("turn_end", self, "turn_end")
		current_turn._start_async()
	else:
		emit_signal("ended")

func next_turn() -> Node:
	var Turn = load("res://Source/Scripts/Battle/Turn.gd")
	var turn = Turn.new()
	init_turn(turn)
	return turn

func first_turn() -> Node:
	var FirstTurn = load("res://Source/Scripts/Battle/FirstTurn.gd")
	var first_turn = FirstTurn.new()
	init_turn(first_turn)
	return first_turn

func init_turn(turn: Node) -> void:
	turn.battle = self
	for trainer in trainers:
		turn.trainers.append(trainer)
	var prev_turns = $Turns.get_children()
	if prev_turns.size() > 0:
		turn.prev_turn = prev_turns[prev_turns.size() - 1]
	turn.owner = $Turns
	$Turns.add_child(turn)

#rename to "register_text_message"
func register_message(message: String) -> void:
	var msg = BattleAnimationMessage.new()
	msg.battle = self
	msg.message = message
	current_turn.register_animation(msg)

func _ready() -> void:
	ally_field = Field.new()
	add_child(ally_field)
	opponent_field = Field.new()
	add_child(battlefield)
	Utils.add_node_if_not_exists(self, self, "Turns")
