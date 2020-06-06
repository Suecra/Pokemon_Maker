extends "res://Source/Scripts/Map/EventNode.gd"

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const StatusCutscene = preload("res://Source/Scripts/Map/CharacterStatus/StatusCutscene.gd")

class_name Event

var map
var caller
var player

func clear():
	event_actions.clear()

func start():
	player.status = StatusCutscene.new()
	yield(execute_event_actions(), "completed")
	end()

func end():
	player.status = StatusFreeMovement.new()

func _ready():
	player = map.player
