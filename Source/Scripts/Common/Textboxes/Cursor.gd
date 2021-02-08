extends Node2D

export(int) var step

var index setget set_index
var start_y: int

func set_index(value: int) -> void:
	if value != index:
		index = value
		position.y = start_y + index * step

func _show() -> void:
	visible = true

func _hide() -> void:
	visible = false

func _ready() -> void:
	start_y = position.y
