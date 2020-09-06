extends "res://Source/Scripts/Map/CharacterStatus.gd"

func end_cutscene() -> void:
	character.status = load("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd").new()

func _enter() -> void:
	if character.controller != null:
		character.controller.set_physics_process(false)
	character.stop()
