extends "res://Source/Scripts/Map/MapObjects/NPC.gd"

class_name Trainer

export(String, MULTILINE) var text_after_defeat
export(String, MULTILINE) var text_after_victory

onready var trainer = $Trainer
var defeated = false

func _trigger():
	character.look_at(map.player.get_position())
	var event = map.get_event(self)
	if defeated:
		event.add_action(EventActionMessage.new(text_after_defeat))
	else:
		event.add_action(EventActionMessage.new(text))
		event.add_action(EventActionBattle.new(map.player.trainer, trainer)).won().add_action(EventActionSetVariable.new(self, "defeated"))
	event.start()
