extends "res://Source/Scripts/Map/CharacterStatus.gd"

func end_cutscene():
	character.status = load("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd").new()

func _enter():
	if character.controller != null:
		character.controller.set_physics_process(false)
	character.stop()
