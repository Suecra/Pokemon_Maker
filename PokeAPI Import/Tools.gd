extends Tabs

const PokemonListCreator = preload("res://Source/Scripts/Collections/PokemonListCreator.gd")
const MoveListCreator = preload("res://Source/Scripts/Collections/MoveListCreator.gd")
const Pokemon = preload("res://Source/Data/Pokemon.gd")

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

func _on_JSONConvert_button_down():
	var move = $tackle
	var json: Dictionary
	move._save_to_json(json)
	var json_string = to_json(json);
	var file = File.new()
	var error = file.open("res://Source/Data/MoveJSON/tackle.json", 2)
	file.store_line(json_string)
	file.close()

func _on_JSONConvertLoad_button_down():
	var move = Move.new()
	move.load_from_file("res://Source/Data/MoveJSON/tackle.json")
	var scene = PackedScene.new()
	scene.pack(move)
	ResourceSaver.save("res://Source/Data/MoveJSON/tackleScene.tscn", scene)
