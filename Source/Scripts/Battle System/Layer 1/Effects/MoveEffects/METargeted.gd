extends "res://Source/Scripts/Battle System/Layer 1/Effects/MoveEffect.gd"

var move_effect: String
var guaranteed_hit: bool
var accuracy: float
var num_hits: int

func _init() -> void:
	set_name("METargeted")
	reg("do_move", 0, L1Consts.SenderType.SELF)

func do_move(target_positions: Array) -> void:
	battle.add_effect(owner, "MoveEffects/" + move_effect)
	for i in range(num_hits):
		for target_position in target_positions:
			var field = battle.battle_l0.battlefield.fields[target_position.x]
			var target = field.get_fighter_at_position(target_position.y)
			if target != null:
				var is_hit = guaranteed_hit
				if not is_hit:
					var hit_chance = n("get_accuracy", [target], accuracy)
					is_hit = random_trigger(hit_chance)
				if is_hit:
					v("hit_target", [target])
