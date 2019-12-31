extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

var counter

func _can_move():
	if counter > 0:
		battle.register_message(subject_owner.nickname + " is fast asleep!")
		return false
	_heal()
	return true

func _heal():
	battle.register_message(subject_owner.nickname + " woke up!")
	._heal()

func _ready():
	status_name = "Sleep"
	register(subject_owner, "TURN_STARTS", "_begin_of_turn")
	battle.register_message(subject_owner.nickname + " fell asleep!")
	counter = randi() % 3 + 1

func _begin_of_turn():
	counter -= 1