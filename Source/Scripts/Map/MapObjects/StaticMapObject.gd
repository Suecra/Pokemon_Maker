extends "res://Source/Scripts/Map/MapObject.gd"

export(String, MULTILINE) var text

func _trigger() -> void:
	var event = Global.new_event(self)
	event.add_action(EventActionMessage.new(text))
	event.start()
