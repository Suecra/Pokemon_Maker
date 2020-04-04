extends Control

export(bool) var custom_border = false
export(NodePath) var text_node

func set_debug_text(value):
	pass

func _resize():
	pass

func _show():
	visible = true

func _hide():
	visible = false