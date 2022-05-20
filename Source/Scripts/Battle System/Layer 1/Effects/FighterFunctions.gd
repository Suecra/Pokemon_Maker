extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")

func _init() -> void:
	set_name("FighterFunctions")

func _register() -> void:
	._register()
	reg("switch", 0, L1Consts.SenderType.SELF)

func switch(fighter: Fighter) -> void:
	owner.active = false
	fighter.position = owner.position
	fighter.active = true
