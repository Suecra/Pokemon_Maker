extends Node

var event_actions := []

func execute_event_actions() -> void:
	for action in event_actions:
		yield(action.execute(), "completed")

func add_action(action: Node) -> Node:
	action.event = self
	event_actions.append(action)
	add_child(action)
	action.owner = self
	return action
