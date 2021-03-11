extends "res://Source/Scripts/Common/Textboxes/Textbox.gd"

const Cursor = preload("res://Source/Scripts/Common/Textboxes/Cursor.gd")

export(PackedScene) var cursor
export(bool) var wrap = false
export(bool) var cancel = false
export(int) var cancel_index = -1

signal selected

var item_index: int setget set_item_index
var cursor_node: Cursor
var count: int
var items: Array
var selection: String

func _set_display_rect(value: Rect2) -> void:
	._set_display_rect(value)
	if cursor_node != null:
		cursor_node.position.x = display_rect.position.x + 7
		cursor_node.position.y = display_rect.position.y + 11

func set_cursor(value: PackedScene) -> void:
	cursor = value
	if cursor_node != null:
		remove_child(cursor_node)
	if cursor != null:
		cursor_node = cursor.instance();
		cursor_node.position.x = display_rect.position.x + 7
		cursor_node.position.y = display_rect.position.y + 11
		add_child(cursor_node)

func set_item_index(value: int) -> void:
	if value != item_index:
		if value >= count:
			if wrap:
				item_index = 0
		elif value < 0:
			if wrap:
				item_index = count - 1
		else:
			item_index = value
		selection = items[item_index]
		cursor_node.index = item_index

func prepare_text() -> String:
	var text = ""
	for item in items:
		if text != "":
			text += "\n"
		text += String(item)
	return text

func display(items: Array) -> void:
	display_async(items)
	yield(self, "selected")

func display_async(items: Array) -> void:
	self.items = items
	count = items.size()
	style.text = prepare_text()
	self.item_index = 0
	style._show()
	cursor_node._show()
	set_process(true)

func close() -> void:
	style._hide()
	cursor_node._hide()
	emit_signal("selected")

func _process(delta: float) -> void:
	var mouse_position = style.get_local_mouse_position()
	var mouse_index: int
	if display_rect.has_point(mouse_position):
		mouse_index = int((mouse_position.y - display_rect.position.y) / cursor_node.step)
		set_item_index(mouse_index)
	if Input.is_action_just_pressed("ui_down"):
		set_item_index(item_index + 1)
	if Input.is_action_just_pressed("ui_up"):
		set_item_index(item_index - 1)
	if Input.is_action_just_pressed("ui_accept"):
		close()
	if cancel && Input.is_action_just_pressed("ui_cancel"):
		item_index = -1
		close()

func _ready() -> void:
	set_process(false)
	self.display_rect = display_rect
	set_cursor(cursor)
	cursor_node._hide()
