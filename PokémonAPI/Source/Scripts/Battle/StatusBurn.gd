extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

const BattleAnimationDamage = preload("res://Source/Scripts/Battle/Animations/BattleAnimationDamage.gd")
const BattleAnimationFaint = preload("res://Source/Scripts/Battle/Animations/BattleAnimationFaint.gd")
const DAMAGE = 1.0 / 16.0

func _end_of_turn():
	battle.register_message(subject_owner.nickname + " was hurt from it's burn!")
	register_damage(subject_owner.damage_percent(DAMAGE))
	if subject_owner.fainted():
		register_faint(subject_owner)
		battle.register_message(subject_owner.nickname + " has fainted!")

func _heal():
	battle.register_message(subject_owner.nickname + " was cured from it's burn!")
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

func _ready():
	status_name = "Burn"
	register(subject_owner, "TURN_ENDS", "_end_of_turn")
	battle.register_message(subject_owner.nickname + " was burned!")
