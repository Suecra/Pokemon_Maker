extends Tabs

const PokemonListCreator = preload("res://Source/Scripts/Collections/PokemonListCreator.gd")
const MoveListCreator = preload("res://Source/Scripts/Collections/MoveListCreator.gd")

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

func _on_BtnCreateMoveList_button_down():
	var creator = MoveListCreator.new()
	add_child(creator)
	creator.create_collection()
	creator.create_from_directory($EditMoveDir.text)
	creator.save_collection()
