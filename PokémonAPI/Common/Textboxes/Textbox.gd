extends CanvasLayer

const TextboxPageList = preload("res://Common/Textboxes/TextboxPageList.gd")

export(PackedScene) var textbox_style
export(int) var lines_per_page = 2
export(float) var chars_per_second = 15
export(bool) var instant
export(bool) var skip
export(bool) var auto_skip
export(bool) var fast_forward
export(float) var display_time = 1.5

var style_container
var text_label
var counter = 0.0
var displaying = false
var page_index
var page_list
var actual_chars_per_second

signal finished

func _physics_process(delta):
	counter += delta
	if displaying:
		if fast_forward && Input.is_action_pressed("ui_accept"):
			actual_chars_per_second = 60.0
		else:
			actual_chars_per_second = chars_per_second
		
		var chars = counter / (1 / actual_chars_per_second)
		if chars >= 1:
			text_label.visible_characters = text_label.visible_characters + int(chars)
			counter = max(0, counter - int(chars))
		if text_label.visible_characters >= page_list.pages[page_index].char_count:
			text_label.visible_characters = page_list.pages[page_index].char_count
			counter = 0
			displaying = false
	else:
		if auto_skip && counter >= display_time:
			counter = 0
			display_next_page()
		if skip && Input.is_action_just_pressed("ui_accept"):
			display_next_page()

func set_textbox_style(value):
	textbox_style = value
	if style_container != null:
		remove_child(style_container)
	if textbox_style != null:
		style_container = textbox_style.instance();
		$Container.add_child(style_container)
		$Container.move_child(style_container, 0)
		text_label = get_node("Container/" + style_container.name + "/" + style_container.text_node)

func display(text: String, bb_code := false):
	display_async(text, bb_code)
	yield(self, "finished")

func display_async(text: String, bb_code := false):
	page_list.is_bbcode = bb_code
	page_list.create_pages(text)
	style_container._show()
	text_label.bbcode_enabled = bb_code
	page_index = -1
	set_physics_process(true)
	display_next_page()

func close():
	style_container._hide()
	emit_signal("finished")

func display_next_page():
	counter = 0
	page_index += 1
	text_label.clear()
	if page_index < page_list.pages.size():
		for i in page_list.pages[page_index].lines.size():
			text_label.add_text(page_list.pages[page_index].lines[i])
			text_label.newline()
		if instant:
			displaying = false
		else:
			text_label.visible_characters = 0
			displaying = true
	else:
		close()

func _ready():
	set_physics_process(false)
	set_textbox_style(textbox_style)
	text_label.scroll_active = false
	page_list = TextboxPageList.new()
	page_list.lines_per_page = lines_per_page
	page_list.font = text_label.get_font("normal_font")
	page_list.textbox_width = text_label.rect_size.x
	style_container._hide()
