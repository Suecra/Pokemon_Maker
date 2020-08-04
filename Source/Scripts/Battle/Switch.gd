extends "res://Source/Scripts/Battle/HalfTurn.gd"

const BattleAnimationOutOfPokeball = preload("res://Source/Scripts/Battle/Animations/BattleAnimationOutOfPokeball.gd")

var to_pokemon: Node

func _init() -> void:
	priority = 6

func _execute() -> void:
	battle.register_message("Sent out " + to_pokemon.nickname + "!")
	if trainer.current_pokemon != null:
		trainer.current_pokemon.switch_out()
	trainer.current_pokemon = to_pokemon
	to_pokemon.switch_in()
	register_switch_in()
	var status_bar = battlefield.get_status_bar(field)
	status_bar.initialize(to_pokemon)
	status_bar.show()

func register_switch_in() -> void:
	var animation = BattleAnimationOutOfPokeball.new()
	animation.pokemon = to_pokemon
	turn.register_animation(animation)
