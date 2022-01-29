extends Reference

const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")

var effect
var priority: int
var sender_type: int

func _init(effect, priority: int, sender_type: int) -> void:
	self.effect = effect
	self.priority = priority
	self.sender_type = sender_type
