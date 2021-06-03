extends "res://Source/Scripts/Battle/HalfTurn.gd"

var tries = 0

func _get_priority() -> int:
	return 6

func _execute() -> void:
	var enemy_pokemon = field.opponent_field.get_all_fighting_pokemon()[0]
	var f = (trainer.current_pokemon.speed * 128 / enemy_pokemon.speed + 30 * tries)
	var r = randi() % 256
	if f > r:
		trainer.left_battle = true
		battle.register_message("You escaped!")
	else:
		tries += 1
		battle.register_message("Can't escape!")
