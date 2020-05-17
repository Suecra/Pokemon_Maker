extends "res://Source/Scripts/Map/MapObjects/StaticMapObject.gd"

class_name NPC

onready var character = $Character

func _get_position():
	return character.get_position()

func _adjust_position():
	character.movement._adjust_position()

func _trigger():
	character.look_at(map.player.get_position())
	._trigger()
