extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var tries: int

func _register() -> void:
	._register()
	tries = 0
	set_name("Escape")
	reg("escape", 0, L1Consts.SenderType.SELF_OR_ALLY)
	reg("try_escape", 0, L1Consts.SenderType.SELF_OR_ALLY)

func escape() -> void:
	battle.battle_l0.state = 3
	battle.add_effect(battle.battle_l0.battlefield, "FieldEffects/Aborted")

func try_escape() -> void:
	var own_speed = i("get_max_speed", [false])
	var opponent_speed = i("get_opponent_max_speed", [false])
	var tries = i("get_run_tries", [])
	var chance = 255 / (own_speed * 128 / opponent_speed + 30 * tries)
	if b("trigger", [chance]):
		v("escape", [])
	tries += 1
