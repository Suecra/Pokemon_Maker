tool

extends Container

export(String) var debug_text setget set_debug_text
export(bool) var custom_border = false
export(Texture) var top_left_corner
export(Texture) var top_right_corner
export(Texture) var bottom_left_corner
export(Texture) var bottom_right_corner
export(Texture) var horizontal_border
export(Texture) var vertical_border

func set_debug_text():
	pass

func _resize():
	pass

func _redraw():
	pass