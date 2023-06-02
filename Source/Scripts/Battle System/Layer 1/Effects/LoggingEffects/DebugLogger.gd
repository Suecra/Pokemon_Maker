extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var fighters: Array
var round_nr: int

func _init() -> void:
	round_nr = 1
	set_name("DebugLogger")

func _register() -> void:
	._register()
	reg("end_of_turn", 0, all_roles())

func end_of_turn() -> void:
	print("Round " + str(round_nr) + " has finished.")
	round_nr += 1
	fighters = arr("get_fighters", [])
	for fighter in fighters:
		print(fighter.name + " has " + str(fighter.hp) + " HP.")
	if battle.battle_l0.state == 2:
		var winner = battle.battle_l0.winner.name
		print("Battle has finished. Winner is " + winner)
