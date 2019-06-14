extends Node

enum BattleEvent {EVENT_BEFORE_MOVE, EVENT_AFTER_MOVE, EVENT_SWITCH_OUT, EVENT_SWITCH_IN, EVENT_BEFORE_TURN, EVENT_AFTER_TURN}

const Utils = preload("res://Source/Scripts/Utils.gd")

export(PackedScene) var player1
export(PackedScene) var player2
export(int) var current_turn

func _ready():
	Utils.add_node_if_not_exists(self, self, "Turns")