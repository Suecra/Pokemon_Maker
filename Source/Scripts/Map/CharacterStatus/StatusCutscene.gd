extends "res://Source/Scripts/Map/CharacterStatus.gd"

func can_move():
	return false

func end_cutscene():
	character.status = load("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd").new()
