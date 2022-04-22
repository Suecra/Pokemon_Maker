extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

func _register() -> void:
	._register()
	set_name("FighterFunctions")
	reg("switch", 0, L1Consts.SenderType.SELF)

func switch(fighter: Fighter) -> void:
	owner.active = false
	fighter.position = owner.position
	fighter.active = true
