extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

func _register() -> void:
	._register()
	reg("nudge", 0, L1Consts.SenderType.BATTLEFIELD)

func nudge() -> void:
	var turn_actions = arr("get_turn_actions", [])
	while turn_actions.size() > 0:
		var top_priority_action = null
		var top_priority = -99
		var tied_actions = []
		for turn_action in turn_actions:
			var priority = turn_action.i("get_priority", [])
			if priority > top_priority:
				top_priority = priority
				top_priority_action = turn_action
				tied_actions.clear()
			elif priority == top_priority:
				var reference_speed = turn_action.f("get_reference_speed", [])
				var top_reference_speed = top_priority_action.f("get_reference_speed", [])
				if reference_speed > top_reference_speed:
					top_priority_action = turn_action
					tied_actions.clear()
				elif reference_speed == top_reference_speed:
					tied_actions.append(turn_action)
		if tied_actions.size() > 0:
			top_priority_action = battle.random_select(tied_actions)
		top_priority_action.v("execute", [])
		turn_actions = arr("get_turn_actions", [])
