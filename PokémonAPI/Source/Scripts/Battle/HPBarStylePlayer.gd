extends "res://Source/Scripts/Battle/HPBarStyle.gd"

func _set_max_hp(value):
	._set_max_hp(value)
	$MaxHP.text = str(value)

func _set_hp(value):
	._set_hp(value)
	$HP.text = str(value)

