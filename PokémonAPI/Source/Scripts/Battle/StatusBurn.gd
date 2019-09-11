extends "res://Source/Scripts/Battle/Status.gd"

const BattleAnimationDamage = preload("res://Source/Scripts/Battle/Animations/BattleAnimationDamage.gd")
const DAMAGE = 1 / 16

func _end_of_turn():
	register_damage(pokemon.damage_percent(DAMAGE))

func heal():
	battle.register_message(pokemon.nickname + " was cured from it's burn!")

func register_damage(damage):
	var damage_animation = BattleAnimationDamage.new()
	damage_animation.status_bar = pokemon.status_bar
	damage_animation.damage = damage
	battle.current_turn.register_animation(damage_animation)

func _ready():
	status_name = "Burn"
