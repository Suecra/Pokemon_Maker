extends WATTest

const RegisteredEffect = preload("res://Source/Scripts/Battle System/Layer 1/RegisteredEffect.gd")
var registered_effect: RegisteredEffect

func pre() -> void:
	registered_effect = RegisteredEffect.new()
