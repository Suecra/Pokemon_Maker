extends "res://Source/Data/Move.gd"

const BattleAnimationStatus = preload("res://Source/Scripts/Battle/Animations/BattleAnimationStatus.gd")

func register_status(pokemon: Node) -> void:
	var animation = BattleAnimationStatus.new()
	animation.pokemon = pokemon
	turn.register_animation(animation)
