extends "res://Source/Scripts/Map/CharacterStatus.gd"

func start_cutscene() -> void:
	character.status = load("res://Source/Scripts/Map/CharacterStatus/StatusCutscene.gd").new()

func _enter() -> void:
	if character.controller != null:
		character.controller.set_physics_process(true)
