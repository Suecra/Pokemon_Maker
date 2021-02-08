extends Node2D

export(float) var margin_left = 0.0
export(float) var margin_right = 0.0
export(float) var margin_top = 0.0
export(float) var margin_bottom = 0.0

var text: String setget set_text
var rect: Rect2 setget set_rect
var visible_chars: int setget set_visible_chars
var font: Font setget ,_get_font

func set_text(value: String) -> void:
	if text != value:
		text = value
		_update_text()

func set_rect(value: Rect2) -> void:
	if rect != value:
		rect = value
		_update_rect()

func set_visible_chars(value: int) -> void:
	visible_chars = value
	_update_visible_chars()

func _update_text() -> void:
	pass

func _update_rect() -> void:
	pass

func _update_visible_chars() -> void:
	pass

func _get_font() -> Font:
	return null

func _show():
	visible = true

func _hide():
	visible = false
