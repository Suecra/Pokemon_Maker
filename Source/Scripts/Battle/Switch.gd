extends "res://Source/Scripts/Battle/HalfTurn.gd"

const BattleAnimationOutOfPokeball = preload("res://Source/Scripts/Battle/Animations/BattleAnimationOutOfPokeball.gd")

var to_pokemon: Node
var forced = false

func _init() -> void:
	priority = 6

func _execute() -> void:
	var message = ""
	if trainer.current_pokemon != null:
		if not forced:
			battle.register_message(trainer._get_switch_out_message())
		trainer.current_pokemon.switch_out()
	trainer.current_pokemon = to_pokemon
	battle.register_message(trainer._get_switch_in_message())
	to_pokemon.switch_in()
	var hp_bar = field.hp_bar
	register_switch_in(hp_bar)
	hp_bar.full_update(to_pokemon)
	hp_bar._show()

func register_switch_in(hp_bar: Node) -> void:
	var animation = BattleAnimationOutOfPokeball.new()
	animation.pokemon = to_pokemon
	animation.hp_bar = hp_bar
	turn.register_animation(animation)
