extends Node

enum BattleEvent {EVENT_BEFORE_MOVE, EVENT_AFTER_MOVE, EVENT_SWITCH_OUT, EVENT_SWITCH_IN, EVENT_BEFORE_TURN, EVENT_AFTER_TURN}

export(int) var priority

func _execute():
	pass