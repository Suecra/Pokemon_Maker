extends "res://Source/Scripts/Map/MapObject.gd"

export(String, MULTILINE) var text

func _ready():
	._ready()
	spawn_radius = 96

func _trigger():
	yield(map.get_message_box().display(text), "completed")
