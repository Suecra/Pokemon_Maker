extends Node2D

export(int) var step
export(int) var index setget set_index

var start_y: int

func set_index(value: int):
	if value != index:
		index = value
		position.y = start_y + index * step

func _show():
	visible = true

func _hide():
	visible = false

func _ready():
	start_y = position.y
	pass
