extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

func _init() -> void:
	cardinality = 1
	set_name("FighterFunctions")

func _register() -> void:
	._register()
	reg("damage", 0, me())
	reg("faint", 0, me())
	reg("switch", 0, me())
	reg("get_fighters", 0, [L1Consts.Role.BATTLEFIELD])

func damage(hp: int) -> void:
	owner.damage(hp)
	if owner.hp == 0:
		v("faint", [])

func faint() -> void:
	owner.fainted = true
	battle.remove_effects(owner, "TurnAction")
	battle.add_effect(owner, "PrimaryStatusEffects/Fainted")

func switch(fighter: Fighter) -> void:
	owner.active = false
	fighter.position = owner.position
	fighter.active = true

func get_fighters() -> BattleArray:
	return BattleInclude.new([owner])
