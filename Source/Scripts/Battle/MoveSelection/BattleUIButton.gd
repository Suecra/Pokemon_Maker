extends Node2D

signal selected

var text: String setget set_text
var bottom_text: String setget set_bottom_text
var right_text: String setget set_right_text
var color setget set_color

onready var text_label := $Text
onready var bottom_text_label := $TextBottom
onready var right_text_label := $TextRight
onready var color_sprite := $move_button/move_button_overlay

var released := true

signal pressed
signal hovered

var move_id: int

func set_text(value: String):
	text_label.text = value

func set_bottom_text(value: String):
	bottom_text_label.text = value

func set_right_text(value: String):
	right_text_label.text = value

func set_color(value: Color):
	color_sprite.modulate = value

func _on_Area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			if released:
				released = false
				emit_signal("pressed", self)
		else:
			released = true

func _on_Area_mouse_entered():
	emit_signal("hovered", self)

func _on_Area_mouse_exited():
	released = true
	
func _ready() -> void:
	visible = false
