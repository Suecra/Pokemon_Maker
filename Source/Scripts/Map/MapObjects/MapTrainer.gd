extends "res://Source/Scripts/Map/MapObjects/NPC.gd"

class_name MapTrainer

export(String, MULTILINE) var text_after_defeat
export(String, MULTILINE) var text_after_victory

onready var trainer := $Trainer
var defeated := false
var approaching := false

func _ready() -> void:
	character.connect("object_spotted", self, "object_spotted")
	character.vision_range = Consts.TRAINER_VISION_RANGE

func object_spotted(object) -> void:
	if defeated:
		character.disconnect("object_spotted", self, "object_spotted")
	elif object == Global.player.body:
		character.disconnect("object_spotted", self, "object_spotted")
		approaching = true
		_trigger()

func _trigger() -> void:
	character.look_at(Global.player.get_position())
	var event = Global.new_event(self)
	if defeated:
		event.add_action(EventActionMessage.new(text_after_defeat))
	else:
		if approaching:
			var distance = Global.player.get_position().distance_to(character.get_position()) - Consts.TILE_SIZE
			var steps = int(distance) / Consts.TILE_SIZE
			event.add_action(EventActionWalk.new(steps))
			approaching = false
		event.add_action(EventActionMessage.new(text))
		event.add_action(EventActionBattle.new(Global.player.trainer, trainer, 1)).won().add_action(EventActionSetVariable.new(self, "defeated"))
	event.start()
