extends Node

const Utils = preload("res://Source/Scripts/Utils.gd")

var trainers = []
var half_turns = []
var battle
var choices_made

func register_action(action):
	$Actions.add_child(action)

func do_actions(event: int):
	var actions = $Actions.get_children()
	for action in actions:
		yield(action._execute(), "completed")
		$RegisteredActions.remove_child(action)

func start():
	choices_made = 0
	for t in trainers:
		t.do_half_turn()

func trainer_choice_made(sender, half_turn):
	add_child(half_turn)
	choices_made += 1
	if choices_made == trainers.size():
		pass

func _ready():
	Utils.add_node_if_not_exists(self, self, "Actions")
	Utils.add_node_if_not_exists(self, self, "HalfTurns")
	
	for t in trainers:
		t.connect("choice_made", self, "trainer_choice_made", [sender, half_turn])