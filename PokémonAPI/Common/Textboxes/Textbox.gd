extends CanvasLayer

export(PackedScene) var textbox_style
export(int) var lines_per_page
export(float) var display_speed
export(bool) var instant

var text
var style_container

func set_textbox_style(value):
	textbox_style = value
	if style_container != null:
		$Container.remove_child(style_container)
	if textbox_style != null:
		style_container = textbox_style.instance();
		$Container.add_child(style_container)
		$Container.move_child(style_container, 0)

func display(text):
	$Container/Text.text = text
	$Container.visible = true

func _ready():
	set_textbox_style(textbox_style)
