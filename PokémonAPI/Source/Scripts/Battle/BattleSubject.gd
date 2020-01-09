extends "res://Source/Scripts/Common/Subject.gd"

var battle
var subject_owner

func _get_priority():
	return subject_owner.current_speed