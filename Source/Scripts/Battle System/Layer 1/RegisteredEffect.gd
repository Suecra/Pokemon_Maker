extends Reference

const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")

var effect
var priority: int
var sender_type: int
var sorted: bool

func _init(effect, priority: int, sender_type: int, sorted: bool) -> void:
	self.effect = effect
	self.priority = priority
	self.sender_type = sender_type
	self.sorted = sorted
