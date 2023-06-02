extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

func _init() -> void:
	set_name("Aborted")

func _register() -> void:
	._register()
	reg("get_turn_actions", 1, all_roles())

func get_turn_actions() -> BattleArray:
	return BattleArray.new([])
