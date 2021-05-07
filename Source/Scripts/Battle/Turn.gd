extends Node

enum ChoiceType {Turn, SwitchInAfterFaint, SwitchInAfterUTurn}

const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")

signal turn_start
signal turn_end

var trainers = []
var half_turns = []
var battle: Node
var choices_made: int
var required_choices: int
var choice_type
var async = false
var animations: Node
var prev_turn: Node

func register_animation(animation: Node) -> void:
	animations.add_child(animation)

func do_half_turns() -> bool:
	PrioritySorter.sort(half_turns)
	for half_turn in half_turns:
		half_turn._execute()
		if half_turn.trainer.left_battle:
			return false
	half_turns.clear()
	return true

func do_animations() -> void:
	for animation in animations.get_children():
		yield(animation._execute(), "completed")
		animations.remove_child(animation)
	yield(get_tree().create_timer(0.0), "timeout")

func force_switch_ins() -> void:
	required_choices = 0
	choice_type = ChoiceType.SwitchInAfterFaint
	for trainer in trainers:
		if not trainer.has_pokemon_left():
			required_choices = 0
			break
		if trainer.current_pokemon.fainted():
			required_choices += 1
			trainer._force_switch_in()
	if not async:
		if required_choices > 0:
			yield(self, "turn_end")
		else:
			yield(get_tree().create_timer(0.0), "timeout")

func _start() -> void:
	choices_made = 0
	required_choices = trainers.size()
	choice_type = ChoiceType.Turn
	for trainer in trainers:
		trainer._do_half_turn()
	yield(self, "turn_end")

func _start_async() -> void:
	async = true
	choices_made = 0
	required_choices = trainers.size()
	choice_type = ChoiceType.Turn
	for trainer in trainers:
		trainer._do_half_turn()

func trainer_choice_made(sender: Node, half_turn: Node) -> void:
	half_turn.turn = self
	half_turn.battle = battle
	half_turn.battlefield = battle.battlefield
	half_turn.field = sender.field
	half_turns.append(half_turn)
	choices_made += 1
	if choices_made == required_choices:
		choices_made = 0
		
		if choice_type == ChoiceType.Turn:
			battle.battlefield.begin_of_turn()
		if do_half_turns() && choice_type == ChoiceType.Turn:
			battle.battlefield.end_of_turn()
		
		if not async:
			yield(do_animations(), "completed")
		if choice_type == ChoiceType.Turn:
			if async:
				force_switch_ins()
			else:
				yield(force_switch_ins(), "completed")
		disconnect_trainers()
		emit_signal("turn_end")

func connect_trainers() -> void:
	for trainer in trainers:
		trainer.connect("choice_made", self, "trainer_choice_made")

func disconnect_trainers() -> void:
	for trainer in trainers:
		trainer.disconnect("choice_made", self, "trainer_choice_made")

func _ready() -> void:
	Utils.add_node_if_not_exists(self, self, "Animations")
	animations = $Animations
	connect_trainers()
