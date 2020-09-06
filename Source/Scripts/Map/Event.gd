extends "res://Source/Scripts/Map/EventNode.gd"

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const StatusCutscene = preload("res://Source/Scripts/Map/CharacterStatus/StatusCutscene.gd")

class_name Event

var map: Node
var caller: Node
var player: Node

func clear() -> void:
	event_actions.clear()

func start() -> void:
	player.status = StatusCutscene.new()
	yield(execute_event_actions(), "completed")
	end()

func end() -> void:
	player.status = StatusFreeMovement.new()

func _ready() -> void:
	player = map.player
