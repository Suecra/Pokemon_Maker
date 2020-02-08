extends Tabs

const PokemonListCreator = preload("res://Source/Scripts/Collections/PokemonListCreator.gd")

func _ready():
	pass

func _on_BtnCreatePokemonList_button_down():
	var creator = PokemonListCreator.new()
	add_child(creator)
	creator.create_collection()
	creator.write_single_icon_path($EditSingleIcons.text)
	creator.write_double_icon_path($EditDoubleIcons.text)
	creator.create_from_directory($EditPokemonDir.text)
	creator.save_collection()
