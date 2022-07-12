extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

func _init() -> void:
	set_name("MoveEffect")
	lasting_turns = 0

func _register() -> void:
	._register()
	reg("fail_move", 0, L1Consts.SenderType.SELF)

func fail_move(move_fail_reason: int) -> void:
	battle.remove_effect(self)
