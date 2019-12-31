extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

const BattleAnimationDamage = preload("res://Source/Scripts/Battle/Animations/BattleAnimationDamage.gd")
const BattleAnimationFaint = preload("res://Source/Scripts/Battle/Animations/BattleAnimationFaint.gd")

func _heal():
	battle.register_message(subject_owner.nickname + " was cured from it's poison!")
	._heal()

func register_damage(damage):
	var damage_animation = BattleAnimationDamage.new()
	damage_animation.status_bar = subject_owner.status_bar
	damage_animation.damage = damage
	battle.current_turn.register_animation(damage_animation)

func register_faint(pokemon):
	var animation = BattleAnimationFaint.new()
	animation.pokemon = pokemon
	battle.current_turn.register_animation(animation)
