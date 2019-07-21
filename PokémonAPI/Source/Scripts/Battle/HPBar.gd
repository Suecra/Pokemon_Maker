extends CanvasLayer

const Utils = preload("res://Source/Scripts/Utils.gd")

export(int) var max_hp
export(int) var hp setget set_hp
export(PackedScene) var style

func set_hp(value: int):
	hp = value
	get_style().hp = hp

func get_style():
	return Utils.unpack(self, style, "Style")