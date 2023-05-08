extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var run_tries: int

func _init() -> void:
	run_tries = 0
	set_name("FieldFunctions")

func _register() -> void:
	._register()
	reg("escape", 0, L1Consts.SenderType.SELF_OR_ALLY)
	reg("try_escape", 0, L1Consts.SenderType.SELF_OR_ALLY)

func escape() -> void:
	battle.battle_l0.state = 3
	battle.add_effect(battle.battle_l0.battlefield, "FieldEffects/Aborted")

func try_escape() -> void:
	var own_speed = f("get_max_speed", [false])
	var opponent_speed = f("get_opponent_max_speed", [false])
	var run_tries = i("get_run_tries", [], run_tries)
	var chance = 255 / (own_speed * 128 / opponent_speed + 30 * run_tries)
	if b("trigger", [chance]):
		v("escape", [])
	run_tries += 1
