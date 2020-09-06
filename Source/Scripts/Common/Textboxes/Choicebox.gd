extends "res://Source/Scripts/Common/Textboxes/Textbox.gd"

const Cursor = preload("res://Source/Scripts/Common/Textboxes/Cursor.gd")

export(PackedScene) var cursor
export(bool) var wrap

signal selected

var item_index: int setget set_item_index
var cursor_node: Cursor
var count: int
var items: Array
var selection: String

func set_cursor(value: PackedScene) -> void:
	cursor = value
	if cursor_node != null:
		remove_child(cursor_node)
	if cursor != null:
		cursor_node = cursor.instance();
		cursor_node.position.x = 3
		cursor_node.position.y = 6
		container.add_child(cursor_node)
		container.move_child(cursor_node, 0)

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
	text_label.text = prepare_text()
	self.item_index = 0
	style_container._show()
	cursor_node._show()
	set_process(true)

func close() -> void:
	style_container._hide()
	cursor_node._hide()
	emit_signal("selected")

func _process(delta: float) -> void:
	var mouse_position = container.get_local_mouse_position()
	var mouse_index: int
	if mouse_position.x > 0 && mouse_position.x < container.rect_size.x:
		if mouse_position.y > 0 && mouse_position.y < cursor_node.step * count:
			mouse_index = int(mouse_position.y / cursor_node.step)
			set_item_index(mouse_index)
	if Input.is_action_just_pressed("ui_down"):
		set_item_index(item_index + 1)
	if Input.is_action_just_pressed("ui_up"):
		set_item_index(item_index - 1)
	if Input.is_action_just_pressed("ui_accept"):
		close()

func _ready() -> void:
	set_process(false)
	set_cursor(cursor)
	cursor_node._hide()
	._ready()
