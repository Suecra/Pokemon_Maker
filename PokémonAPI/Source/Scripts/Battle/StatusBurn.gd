extends "res://Source/Scripts/Battle/Status.gd"

const BattleAnimationDamage = preload("res://Source/Scripts/Battle/Animations/BattleAnimationDamage.gd")
const BattleAnimationFaint = preload("res://Source/Scripts/Battle/Animations/BattleAnimationFaint.gd")
const DAMAGE = 1 / 16

func _end_of_turn():
	battle.register_message(pokemon.nickname + " was hurt from it's burn!")
	register_damage(pokemon.damage_percent(DAMAGE))
	if pokemon.fainted():
		register_faint(pokemon)
		battle.register_message(pokemon.nickname + " has fainted!")

func heal():
	battle.register_message(pokemon.nickname + " was cured from it's burn!")

func register_damage(damage):
	var damage_animation = BattleAnimationDamage.new()
	damage_animation.status_bar = pokemon.status_bar
	damage_animation.damage = damage
	battle.current_turn.register_animation(damage_animation)

func register_faint(pokemon):
	var animation = BattleAnimationFaint.new()
	animation.pokemon = pokemon
	battle.current_turn.register_animation(animation)

func _ready():
	status_name = "Burn"
	battle.register_message(pokemon.nickname + " was burned!")
