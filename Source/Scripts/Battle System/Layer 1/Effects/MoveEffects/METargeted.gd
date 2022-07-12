extends "res://Source/Scripts/Battle System/Layer 1/Effects/MoveEffect.gd"

var guaranteed_hit: bool
var accuracy: float
var hit_count: int

func _init() -> void:
	set_name("METargeted")

func _register() -> void:
	._register()
	reg("do_move", 0, L1Consts.SenderType.SELF)

func do_move(target_positions: Array) -> void:
	var no_target = true
	var hc = n("get_hit_count", []).value
	for i in range(hit_count):
		for target_position in target_positions:
			var field = battle.battle_l0.battlefield.fields[target_position.x]
			var target = field.get_fighter_at_position(target_position.y)
			if target != null:
				no_target = false
				var is_hit = guaranteed_hit
				if not is_hit:
					var hit_chance = n("get_accuracy", [target], accuracy)
					is_hit = random_trigger(hit_chance)
				if is_hit:
					v("hit_target", [target])
	if no_target:
		v("fail_move", [L1Consts.MoveFailReason.NO_TARGET])
