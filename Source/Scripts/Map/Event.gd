extends Node

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const StatusCutscene = preload("res://Source/Scripts/Map/CharacterStatus/StatusCutscene.gd")

class_name Event

var map
var player
var event_actions = []

func clear():
	event_actions.clear()

func start():
	player.status = StatusCutscene.new()
	for action in event_actions:
		yield(action.execute(), "completed")
	end()

func end():
	player.status = StatusFreeMovement.new()

func add_action(action: EventAction):
	action.event = self
	event_actions.append(action)
	add_child(action)
	action.owner = self

func _ready():
	player = map.player
