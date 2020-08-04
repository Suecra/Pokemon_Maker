extends Node

enum HitRange {Opponent, All_Opponents, All, User, Partner, User_or_Partner, User_Field, Opponent_Field, Entire_Field}

signal targets_selected(target_positions)

var hit_range: int
var user_position: int
var possible_target_positions = []

func _show_selection() -> void:
	possible_target_positions = []
	if hit_range == HitRange.Opponent:
		possible_target_positions.append(user_position + 3)
	elif hit_range == HitRange.User:
		possible_target_positions.append(user_position)
	else:
		possible_target_positions.append(user_position + 3)

func _select(index: int) -> void:
	if has_choice():
		emit_signal("targets_selected", [possible_target_positions[index]])
	else:
		emit_signal("targets_selected", possible_target_positions)

func has_choice() -> bool:
	match hit_range:
		HitRange.Opponent, HitRange.User_or_Partner: return true
	return false
