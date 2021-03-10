extends "res://Source/Scripts/Common/Textboxes/Textbox.gd"

const TextboxPageList = preload("res://Source/Scripts/Common/Textboxes/TextboxPageList.gd")

export(int) var lines_per_page = 2
export(float) var chars_per_second = 15
export(bool) var instant
export(bool) var skip
export(bool) var auto_skip
export(bool) var auto_hide
export(bool) var fast_forward
export(float) var display_time = 1.5

var counter := 0.0
var displaying := false
var page_index: int
var page_list: TextboxPageList
var actual_chars_per_second: float

signal finished
signal finsihed_display

func _set_display_rect(value: Rect2) -> void:
	._set_display_rect(value)
	if page_list != null:
		page_list.textbox_width = value.size.x - style.margin_left - style.margin_right

func _physics_process(delta: float) -> void:
	counter += delta
	if displaying:
		if fast_forward && Input.is_action_pressed("textbox_skip"):
			actual_chars_per_second = chars_per_second * 4
		else:
			actual_chars_per_second = chars_per_second
		
		var chars = counter / (1 / actual_chars_per_second)
		if chars >= 1:
			style.visible_chars = style.visible_chars + int(chars)
			counter = max(0, counter - int(chars))
		if style.visible_chars >= page_list.pages[page_index].char_count:
			style.visible_chars = page_list.pages[page_index].char_count
			counter = 0
			if page_index >= page_list.pages.size() - 1:
				emit_signal("finsihed_display")
			displaying = false
	else:
		if auto_skip && counter >= display_time:
			counter = 0
			display_next_page()
		if skip && Input.is_action_just_pressed("textbox_skip"):
			display_next_page()

func display(text: String) -> void:
	display_async(text)
	yield(self, "finished")

func display_async(text: String) -> void:
	page_list.is_bbcode = false
	page_list.create_pages(text)
	style._show()
	page_index = -1
	set_physics_process(true)
	display_next_page()

func close() -> void:
	set_physics_process(false)
	if auto_hide:
		style.text = ""
		style._hide()
	emit_signal("finished")

func display_next_page() -> void:
	counter = 0
	page_index += 1
	if page_index < page_list.pages.size():
		style.text = ""
		var text = ""
		for i in page_list.pages[page_index].lines.size():
			if text != "":
				text = text + "\n"
			text = text + page_list.pages[page_index].lines[i]
		print(text)
		style.text = text
		if instant:
			displaying = false
		else:
			style.visible_chars = 0
			displaying = true
	else:
		close()

func _ready() -> void:
	page_list = TextboxPageList.new()
	page_list.lines_per_page = lines_per_page
	page_list.font = style.font
	self.display_rect = display_rect
