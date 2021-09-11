tool
extends Control

const ID_VAR = "{id}"
const NAME_VAR = "{name}"
const PRESET_PATH = "res://Import/Presets/"
const PokemonList = preload("res://Source/Scripts/Collections/PokemonList.gd")
const SpriteCollection = preload("res://Source/Scripts/Common/SpriteCollection.gd")
const SpriteCollectionSimple = preload("res://Source/Scripts/Common/SpriteCollectionSimple.gd")

var selecting_collections_path = false
var pokemon_list: PokemonList

class FilePattern extends Reference:
	var start_regex: String
	var end_regex: String
	var is_id_var: bool
	var sprite_id: int
	var pokemon_list: Reference
	
	func create(pattern: String, pokemon_list: Reference) -> void:
		pattern = pattern.to_lower().replace("/", "\\/")
		self.pokemon_list = pokemon_list
		is_id_var = false
		var id_var_idx = pattern.find(ID_VAR)
		if id_var_idx == -1:
			var name_var_idx = pattern.find(NAME_VAR)
			if name_var_idx == -1:
				start_regex = "^" + pattern + "$"
				end_regex = start_regex
				return
			start_regex = "^" + pattern.substr(0, name_var_idx)
			end_regex = pattern.substr(name_var_idx + NAME_VAR.length()) + "$"
			return
		start_regex = "^" + pattern.substr(0, id_var_idx)
		end_regex = pattern.substr(id_var_idx + ID_VAR.length()) + "$"
		is_id_var = true
	
	func is_match(file: String) -> int:
		var regex = RegEx.new()
		regex.compile(start_regex)
		var match_start = regex.search(file)
		if match_start != null:
			regex.compile(end_regex)
			var match_end = regex.search(file)
			if match_end != null:
				var start_idx = match_start.get_end()
				var var_string = file.substr(start_idx, match_end.get_start() - start_idx)
				var dict = pokemon_list.pokemon_list
				if is_id_var:
					if var_string.is_valid_integer():
						return int(var_string)
				elif dict.has(var_string):
					return dict[var_string]
		return -1

func _ready():
	$EditCollections.text = Consts.SPRITE_COLLECTION_PATH
	pokemon_list = PokemonList.new()
	pokemon_list.load_list()

func _on_ButtonImport_button_down():
	if $EditSprites.text == "":
		do_log("Sprite directory not specified!")
		return
	if $EditCollections.text == "":
		do_log("Sprite-Collection directory not specified!")
		return
	
	var dir = Directory.new()
	if not dir.dir_exists($EditCollections.text):
		dir.make_dir($EditCollections.text)
	
	var files = []
	var patterns = []
	var pattern
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditMaleFrontPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditFemaleFrontPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Female_Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditMaleBackPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Back
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditFemaleBackPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Female_Back
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditMaleFrontPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Shiny_Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditFemaleFrontPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Shiny_Female_Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditMaleBackPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Shiny_Back
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditFemaleBackPattern.text, pokemon_list)
	pattern.sprite_id = SpriteCollection.Sprites.Shiny_Female_Back
	patterns.append(pattern)
	
	get_all_files(files, "")
	var count = files.size()
	var pkmn_id
	var sprite_collection
	var i = 0
	var progress = 0.0
	var last_progress = 0
	for file in files:
		for pat in patterns:
			pkmn_id = pat.is_match(file.to_lower())
			if pkmn_id != -1:
				save_to_sprite_collection($EditSprites.text + "/" + file, pkmn_id, pat.sprite_id)
				break
		if pkmn_id == -1:
			do_log("No match for \"" + file + "\"")
		i = i + 1
		progress = i / float(count) * 100
		if progress >= last_progress + 1:
			last_progress = int(progress)
			$ProgressBar.value = last_progress
			yield(get_tree().create_timer(0.02), "timeout")
	do_log("Import finished")

func get_all_files(array: Array, sub_dir: String) -> void:
	var directory = Directory.new()
	if directory.open($EditSprites.text + "/" + sub_dir) == OK:
		directory.list_dir_begin(true, true)
		var filename = directory.get_next()
		while filename != "":
			if directory.current_is_dir():
				get_all_files(array, sub_dir + filename + "/")
			elif not filename.ends_with(".import"):
				array.append(sub_dir + filename)
			filename = directory.get_next()

func save_to_sprite_collection(file: String, pokemon_id: int, sprite_id: int) -> void:
	var sprites_name = String(pokemon_id)
	while sprites_name.length() < 4:
		sprites_name = "0" + sprites_name
	var scene_path = Consts.SPRITE_COLLECTION_PATH + sprites_name + ".tscn"
	var sprite_collection
	var scene = load(scene_path)
	if scene == null:
		sprite_collection = SpriteCollectionSimple.new()
	else:
		sprite_collection = scene.instance()
	sprite_collection.name = sprites_name
	var texture = load(file)
	match sprite_id:
		SpriteCollection.Sprites.Front: sprite_collection.front = texture
		SpriteCollection.Sprites.Female_Front: sprite_collection.female_front = texture
		SpriteCollection.Sprites.Shiny_Front: sprite_collection.shiny_front = texture
		SpriteCollection.Sprites.Shiny_Female_Front: sprite_collection.shiny_female_front = texture
		SpriteCollection.Sprites.Back: sprite_collection.back = texture
		SpriteCollection.Sprites.Female_Back: sprite_collection.female_back = texture
		SpriteCollection.Sprites.Shiny_Back: sprite_collection.shiny_back = texture
		SpriteCollection.Sprites.Shiny_Female_Back: sprite_collection.shiny_female_back = texture
	scene = PackedScene.new()
	scene.pack(sprite_collection)
	ResourceSaver.save(scene_path, scene)

func enable_import_button() -> void:
	var enabled = $EditSprites.text != ""
	enabled = enabled && $EditCollections.text != ""
	enabled = enabled && $PanelNormalSprites/EditMaleFrontPattern.text != ""
	enabled = enabled && $PanelNormalSprites/EditMaleBackPattern.text != ""
	enabled = enabled && $PanelNormalSprites/EditFemaleFrontPattern.text != ""
	enabled = enabled && $PanelNormalSprites/EditFemaleBackPattern.text != ""
	enabled = enabled && $PanelShinySprites/EditMaleFrontPattern.text != ""
	enabled = enabled && $PanelShinySprites/EditMaleBackPattern.text != ""
	enabled = enabled && $PanelShinySprites/EditFemaleFrontPattern.text != ""
	enabled = enabled && $PanelShinySprites/EditFemaleBackPattern.text != ""
	$ButtonImport.disabled = not enabled

func _on_text_changed(new_text: String) -> void:
	enable_import_button()

func do_log(text: String) -> void:
	print(text)

func _on_ButtonLoadPreset_button_down():
	$PresetDialog.mode = FileDialog.MODE_OPEN_FILE
	$PresetDialog.visible = true
	$PresetDialog.invalidate()

func _on_ButtonSavePreset_button_down():
	$PresetDialog.mode = FileDialog.MODE_SAVE_FILE
	$PresetDialog.visible = true
	$PresetDialog.invalidate()

func _on_ButtonSprites_button_down():
	selecting_collections_path = false
	$DirectoryDialog.visible = true
	$DirectoryDialog.invalidate()

func _on_ButtonSpriteCollections_button_down():
	selecting_collections_path = true
	$DirectoryDialog.visible = true
	$DirectoryDialog.invalidate()

func _on_DirectoryDialog_dir_selected(dir):
	if selecting_collections_path:
		$EditCollections.text = dir
	else:
		$EditSprites.text = dir
	enable_import_button()

func _on_PresetDialog_file_selected(path):
	var dict: Dictionary
	var file = File.new()
	if $PresetDialog.mode == FileDialog.MODE_OPEN_FILE:
		file.open(path, File.READ)
		dict = parse_json(file.get_as_text())
		if dict.has("front"):
			$PanelNormalSprites/EditMaleFrontPattern.text = dict["front"]
		if dict.has("back"):
			$PanelNormalSprites/EditMaleBackPattern.text = dict["back"]
		if dict.has("female_front"):
			$PanelNormalSprites/EditFemaleFrontPattern.text = dict["female_front"]
		if dict.has("female_back"):
			$PanelNormalSprites/EditFemaleBackPattern.text = dict["female_back"]
		if dict.has("shiny_front"):
			$PanelShinySprites/EditMaleFrontPattern.text = dict["shiny_front"]
		if dict.has("shiny_back"):
			$PanelShinySprites/EditMaleBackPattern.text = dict["shiny_back"]
		if dict.has("shiny_female_front"):
			$PanelShinySprites/EditFemaleFrontPattern.text = dict["shiny_female_front"]
		if dict.has("shiny_feamle_back"):
			$PanelShinySprites/EditFemaleBackPattern.text = dict["shiny_feamle_back"]
		enable_import_button()
	else:
		file.open(path, File.WRITE)
		dict["front"] = $PanelNormalSprites/EditMaleFrontPattern.text
		dict["back"] = $PanelNormalSprites/EditMaleBackPattern.text
		dict["female_front"] = $PanelNormalSprites/EditFemaleFrontPattern.text
		dict["female_back"] = $PanelNormalSprites/EditFemaleBackPattern.text
		dict["shiny_front"] = $PanelShinySprites/EditMaleFrontPattern.text
		dict["shiny_back"] = $PanelShinySprites/EditMaleBackPattern.text
		dict["shiny_female_front"] = $PanelShinySprites/EditFemaleFrontPattern.text
		dict["shiny_feamle_back"] = $PanelShinySprites/EditFemaleBackPattern.text
		file.store_string(to_json(dict))
	file.close()
