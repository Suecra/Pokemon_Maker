extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

func _register() -> void:
	._register()
	set_name("Aborted")
	reg("get_turn_actions", 1, L1Consts.SenderType.BATTLEFIELD)

func get_turn_actions() -> BattleArray:
	return BattleArray.new([])
