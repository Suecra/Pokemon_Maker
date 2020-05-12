extends "res://Source/Scripts/Map/MapObject.gd"

export(String, MULTILINE) var text

func _ready():
	._ready()
	spawn_radius = 15 * 16

func _trigger():
	var event = map.get_event()
	var event_action = EventActionMessage.new()
	event_action.message = text
	event.add_action(event_action)
	event.start()
