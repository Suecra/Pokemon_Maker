extends CanvasLayer

export(PackedScene) var textbox_style
export(Rect2) var display_rect: Rect2 setget _set_display_rect

var style: Node2D

func _set_display_rect(value: Rect2) -> void:
	display_rect = value
	if style != null:
		style.rect = display_rect

func _ready() -> void:
	set_physics_process(false)
	style = textbox_style.instance()
	style.name = "Style"
	add_child(style)
	style.owner = self
