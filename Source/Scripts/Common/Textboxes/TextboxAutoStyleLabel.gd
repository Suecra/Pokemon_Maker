extends "res://Source/Scripts/Common/Textboxes/TextboxAutoStyle.gd"

export(NodePath) var label_path

onready var label := get_node(label_path)

func _update_rect() -> void:
	label.rect_position = Vector2(rect.position.x + margin_left, rect.position.y + margin_top)
	label.rect_size = Vector2(rect.size.x - margin_left - margin_right, rect.size.y - margin_top - margin_bottom)

func _update_text() -> void:
	label.text = text

func _update_visible_chars() -> void:
	label.visible_characters = visible_chars

func _get_font() -> Font:
	return label.get_font("normal_font")
