extends Control

export(int) var max_amount = 6

signal add
signal remove

var next_item_text: String
var next_item_icon: Texture

func _on_BtnAdd_button_down():
	if $ItemList.get_item_count() < max_amount:
		next_item_text = "Element"
		next_item_icon = null
		emit_signal("add")
		$ItemList.add_item(next_item_text, next_item_icon)
		$ItemList.select($ItemList.get_item_count() - 1)

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
	$ItemList.select(min($ItemList.get_item_count() - 1, last_removed_index))
