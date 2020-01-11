extends "res://Source/Scripts/Battle/Status.gd"

const BattleAnimationStatus = preload("res://Source/Scripts/Battle/Animations/BattleAnimationStatus.gd")

func _pokemon_fainted():
	return false

func _can_move():
	return true

func _ready():
	var animation_status = BattleAnimationStatus.new()
	animation_status.pokemon = pokemon
	battle.current_turn.register_animation(animation_status)