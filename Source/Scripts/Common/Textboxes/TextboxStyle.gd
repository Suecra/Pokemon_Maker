extends Control

export(bool) var custom_border = false
export(NodePath) var text_node

func set_debug_text(value: String) -> void:
	pass

func _resize() -> void:
	pass

func _show() -> void:
	visible = true

func _hide() -> void:
	visible = false
