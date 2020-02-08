extends LineEdit

const PokemonList = preload("res://Source/Scripts/Collections/PokemonList.gd")

signal pokemon_selected

func _ready():
	pass

func update_item_list(filter_text):
	var items = PokemonList.get_pokemon_filter_dict(filter_text)
	$PokemonList.clear()
	for key in items.keys():
		$PokemonList.add_icon_item(PokemonList.get_single_icon(items[key]["id"]), key.capitalize(), items[key]["id"])
	pass

func _on_EditSpecies_text_changed(new_text):
	if new_text == "":
		$PokemonList.visible = false
	else:
		update_item_list(new_text)
		var rect = get_global_rect()
		rect.position.y += get_rect().size.y
		$PokemonList.popup(rect)
		grab_focus()

func _on_PokemonList_index_pressed(index):
	text = $PokemonList.get_item_text(index).to_lower()
	emit_signal("pokemon_selected", text)

func _on_EditSpecies_gui_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_DOWN:
			$PokemonList.grab_focus()

func _on_EditSpecies_text_entered(new_text):
	if $PokemonList.get_item_count() > 0:
		text = $PokemonList.get_item_text(0).to_lower()
		emit_signal("pokemon_selected", text)
	$PokemonList.visible = false
