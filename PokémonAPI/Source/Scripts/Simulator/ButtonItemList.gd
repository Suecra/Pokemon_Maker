extends Control

export(int) var max_amount = 6

signal add
signal remove
signal select
signal save_required

var next_item_text: String
var next_item_icon: Texture
var selected_index := -1

func get_item_index():
	var i = 0
	while i < $ItemList.get_item_count():
		if $ItemList.is_selected(i):
			return i
		i += 1
	return -1

func load_from_strings(strings):
	$ItemList.clear()
	for s in strings:
		$ItemList.add_item(s)
	selected_index = $ItemList.get_item_count() - 1
	$ItemList.select(selected_index)

func set_selected_text(text: String):
	var item_index = get_item_index()
	if item_index != -1:
		$ItemList.set_item_text(item_index, text)

func set_selected_icon(icon: Texture, index: int = -1):
	if index == -1:
		index = get_item_index()
	if index != -1:
		$ItemList.set_item_icon(index, icon)

func _on_BtnAdd_button_down():
	if $ItemList.get_item_count() < max_amount:
		if selected_index != -1:
			emit_signal("save_required", selected_index)
		next_item_text = "Element"
		next_item_icon = null
		emit_signal("add")
		$ItemList.add_item(next_item_text, next_item_icon)
		selected_index = $ItemList.get_item_count() - 1
		$ItemList.select(selected_index)

func _on_BtnRemove_button_down():
	var i = 0
	var last_removed_index = -1
	while i < $ItemList.get_item_count():
		if $ItemList.is_selected(i):
			$ItemList.remove_item(i)
			last_removed_index = i
			emit_signal("remove", i)
		else:
			i += 1
	selected_index = min($ItemList.get_item_count() - 1, last_removed_index)
	$ItemList.select(selected_index)

func _on_ItemList_item_selected(index):
	if selected_index != -1:
		emit_signal("save_required", selected_index)
	selected_index = index
	emit_signal("select", index)
