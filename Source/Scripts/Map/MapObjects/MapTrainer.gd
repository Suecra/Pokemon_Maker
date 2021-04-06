extends "res://Source/Scripts/Map/MapObjects/NPC.gd"

class_name MapTrainer

export(String, MULTILINE) var text_after_defeat
export(String, MULTILINE) var text_after_victory

onready var trainer := $Trainer
var defeated := false

func _trigger() -> void:
	character.look_at(Global.player.get_position())
	var event = Global.new_event(self)
	if defeated:
		event.add_action(EventActionMessage.new(text_after_defeat))
	else:
		event.add_action(EventActionTurn.new(EventActionTurn.Direction.Left))
		event.add_action(EventActionRun.new(5))
		event.add_action(EventActionMessage.new(text))
		event.add_action(EventActionBattle.new(Global.player.trainer, trainer)).won().add_action(EventActionSetVariable.new(self, "defeated"))
	event.start()
