extends Node

const Utils = preload("res://Source/Scripts/Utils.gd")
const PrioritySorter = preload("res://Source/Scripts/Battle/PrioritySorter.gd")

signal turn_start
signal turn_end

var trainers = []
var half_turns = []
var battle
var prev_turn
var choices_made

func register_action(action):
	$Actions.add_child(action)

func do_half_turns():
	emit_signal("turn_start")
	PrioritySorter.sort(half_turns)
	for half_turn in half_turns:
		half_turn._execute()

func do_actions():
	var actions = $Actions.get_children()
	for action in actions:
		yield(action._execute(), "completed")
		$RegisteredActions.remove_child(action)
	yield(get_tree().create_timer(0.0), "timeout")

func start():
	print("Turn starts")
	choices_made = 0
	for t in trainers:
		t._do_half_turn()
	yield(self, "turn_end")

func trainer_choice_made(sender, half_turn):
	half_turn.turn = self
	half_turn.battle = battle
	half_turn.field = sender.field
	half_turns.append(half_turn)
	choices_made += 1
	if choices_made == trainers.size():
		print("Choices made")
		do_half_turns()
		yield(do_actions(), "completed")
		emit_signal("turn_end")

func _ready():
	Utils.add_node_if_not_exists(self, self, "Actions")
	for t in trainers:
		t.connect("choice_made", self, "trainer_choice_made")