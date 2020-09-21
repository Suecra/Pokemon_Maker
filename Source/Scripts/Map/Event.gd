extends "res://Source/Scripts/Map/EventNode.gd"

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const StatusCutscene = preload("res://Source/Scripts/Map/CharacterStatus/StatusCutscene.gd")

class_name Event

var caller: Node

func clear() -> void:
	event_actions.clear()

func start() -> void:
	Global.player.status = StatusCutscene.new()
	yield(execute_event_actions(), "completed")
	end()

func end() -> void:
	Global.player.status = StatusFreeMovement.new()
