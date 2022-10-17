extends "res://Source/Scripts/Battle System/Layer 2/TrainerController.gd"

func _request_action(pokemon) -> void:
	var moves = battle.get_possible_moves(pokemon)
	battle.move(trainer, pokemon, moves[0].name, 0)
