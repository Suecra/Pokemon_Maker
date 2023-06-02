extends Reference

const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")

var effect
var priority: int
var roles: Array
var sorted: bool

func _init(effect, priority: int, roles: Array, sorted: bool) -> void:
	self.effect = effect
	self.priority = priority
	self.roles = roles
	self.sorted = sorted
