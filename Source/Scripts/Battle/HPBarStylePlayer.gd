extends "res://Source/Scripts/Battle/HPBarStyle.gd"

onready var max_hp_label := $MaxHP
onready var hp_label := $HP

func _set_max_hp(value: int) -> void:
	._set_max_hp(value)
	max_hp_label.text = str(value)

func _set_hp(value: int) -> void:
	._set_hp(value)
	hp_label.text = str(int(value))

