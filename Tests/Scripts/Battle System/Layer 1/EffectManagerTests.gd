extends WATTest

const EffectManager = preload("res://Source/Scripts/Battle System/Layer 1/EffectManager.gd")
var effect_manager: EffectManager

func test_send() -> void:
	pass

func test_call_method() -> void:
	pass

func test_register() -> void:
	pass

func pre() -> void:
	effect_manager = EffectManager.new()
