extends "res://Source/Scripts/Map/MapObject.gd"

export(String, MULTILINE) var text

func _ready() -> void:
	._ready()
	spawn_radius = 15 * 16

func _trigger() -> void:
	var event = map.get_event(self)
	event.add_action(EventActionMessage.new(text))
	event.start()
