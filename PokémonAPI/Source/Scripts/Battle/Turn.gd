extends Node

enum ChoiceType {Turn, SwitchInAfterFaint, SwitchInAfterUTurn}

const Utils = preload("res://Source/Scripts/Utils.gd")
const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")

signal turn_start
signal turn_end

var trainers = []
var half_turns = []
var battle
var prev_turn
var choices_made
var required_choices
var choice_type

func register_animation(animation):
	$Animations.add_child(animation)

func do_half_turns():
	PrioritySorter.sort(half_turns)
	for half_turn in half_turns:
		half_turn._execute()
	half_turns.clear()

func do_animations():
	var animations = $Animations.get_children()
	for animation in animations:
		yield(animation._execute(), "completed")
		$Animations.remove_child(animation)
	yield(get_tree().create_timer(0.0), "timeout")

func force_switch_ins():
	required_choices = 0
	choice_type = ChoiceType.SwitchInAfterFaint
	for t in trainers:
		if not t.has_pokemon_left():
			required_choices = 0
			break
		if t.current_pokemon.fainted():
			required_choices += 1
			t._force_switch_in()
	if required_choices > 0:
		yield(self, "turn_end")
	else:
		yield(get_tree().create_timer(0.0), "timeout")

func _start():
	choices_made = 0
	required_choices = trainers.size()
	choice_type = ChoiceType.Turn
	for t in trainers:
		t._do_half_turn()
	yield(self, "turn_end")

func trainer_choice_made(sender, half_turn):
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
		do_half_turns()
		if choice_type == ChoiceType.Turn:
			battle.battlefield.end_of_turn()
		
		yield(do_animations(), "completed")
		if choice_type == ChoiceType.Turn:
				yield(force_switch_ins(), "completed")
		disconnect_trainers()
		emit_signal("turn_end")

func connect_trainers():
	for t in trainers:
		t.connect("choice_made", self, "trainer_choice_made")

func disconnect_trainers():
	for t in trainers:
		t.disconnect("choice_made", self, "trainer_choice_made")

func _ready():
	Utils.add_node_if_not_exists(self, self, "Animations")
	connect_trainers()
	