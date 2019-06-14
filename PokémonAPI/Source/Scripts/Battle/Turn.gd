extends Node

const Utils = preload("res://Source/Scripts/Utils.gd")

export(PackedScene) var half_turn1
export(PackedScene) var half_turn2

func register_action(action):
	$RegisteredActions.add_child(action)
	pass

func do_actions(event: int):
	var actions = $Actions.get_children()
	for action in actions:
		if action.event == event:
			yield(action.battle_object._do_action(), "completed")
			$RegisteredActions.remove_child(action)

func _ready():
	Utils.add_node_if_not_exists(self, self, "Actions")