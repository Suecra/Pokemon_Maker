extends "res://Source/Scripts/Map/CharacterStatus.gd"

func can_move():
	return true

func start_cutscene():
	character.status = load("res://Source/Scripts/Map/CharacterStatus/StatusCutscene.gd").new()
