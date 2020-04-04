extends LineEdit

export(int) var max_filter_result = 10
export(int) var item_height = 1
export(Array, String) var item_hints

signal item_selected

func update_item_list(items, count: int):
	var i = 0
	$List.clear()
	if items is Dictionary:
		for key in items.keys():
			if i >= count:
				break
			_add_dictionary_item(items[key], key)
			i += 1
	else:
		for item in items:
			if i >= count:
				break
			_add_item(item)
			i += 1

func _get_items(filter: String):
	var filtered_items = []
	for item in item_hints:
		if item.to_lower().begins_with(filter.to_lower()):
			filtered_items.append(item)
	return filtered_items

func _add_item(item):
	$List.add_item(item)

func _add_dictionary_item(item, key):
	pass

func text_changed(new_text):
	if new_text == "":
		$List.visible = false
	else:
		update_item_list(_get_items(new_text), get_visible_item_count())
		var rect = get_global_rect()
		rect.position.y += get_rect().size.y
		$List.popup(rect)
		grab_focus()

func get_visible_item_count():
	var count = int((OS.window_size.y - rect_position.y) / item_height)
	return min(count, max_filter_result)

func gui_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_DOWN:
			$List.grab_focus()

func text_entered(new_text):
	if $List.get_item_count() > 0:
		text = $List.get_item_text(0).to_lower()
		emit_signal("item_selected", text)
	$List.visible = false

func index_pressed(index):
	text = $List.get_item_text(index).to_lower()
	emit_signal("item_selected", text)

func _ready():
	connect("text_changed", self, "text_changed")
	connect("text_entered", self, "text_entered")
	connect("gui_input", self, "gui_input")
	$List.connect("index_pressed", self, "index_pressed")
