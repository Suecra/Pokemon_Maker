extends "res://Source/Scripts/Battle System/Layer 1/Effect.gd"

var i := 0

func _register() -> void:
	._register()
	set_name("Test")
	reg("nudge", 1, [L1Consts.Role.SELF])

func nudge() -> void:
	i = i + 1
