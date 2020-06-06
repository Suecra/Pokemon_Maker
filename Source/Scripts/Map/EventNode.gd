extends Node

var event_actions = []

func execute_event_actions():
	for action in event_actions:
		yield(action.execute(), "completed")

func add_action(action):
	action.event = self
	event_actions.append(action)
	add_child(action)
	action.owner = self
	return action
