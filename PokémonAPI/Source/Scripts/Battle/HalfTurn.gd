extends Node

export(int) var priority
export(int) var TEST_speed

var trainer
var pokemon
var turn
var battle

func _execute():
	pass

func _ready():
	pass

func _enter_tree():
	turn = get_parent()
	battle = turn.battle
