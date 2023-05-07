extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

func _init() -> void:
	set_name("FighterFunctions")

func _register() -> void:
	._register()
	reg("damage", 0, L1Consts.SenderType.SELF)
	reg("switch", 0, L1Consts.SenderType.SELF)
	reg("get_fighters", 0, L1Consts.SenderType.BATTLEFIELD)

func damage(hp: int) -> void:
	owner.damage(hp)

func switch(fighter: Fighter) -> void:
	owner.active = false
	fighter.position = owner.position
	fighter.active = true

func get_fighters() -> BattleArray:
	return BattleInclude.new([owner])
