extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionMessage

export(String, MULTILINE) var message

func _execute() -> bool:
	var message_box = event.map.get_message_box()
	message_box.connect("finished", self, "finish")
	message_box.display_async(message)
	return true

func _init(message: String) -> void:
	self.message = message
