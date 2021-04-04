extends Tabs

const ID_VAR = "{id}"
const NAME_VAR = "{name}"
const PokemonList = preload("res://Source/Scripts/Collections/PokemonList.gd")
const SpriteCollection = preload("res://Source/Scripts/Common/SpriteCollection.gd")
const SpriteCollectionSimple = preload("res://Source/Scripts/Common/SpriteCollectionSimple.gd")

class FilePattern extends Reference:
	var start_regex: String
	var end_regex: String
	var is_id_var: bool
	var sprite_id: int
	
	func create(pattern: String) -> void:
		pattern = pattern.replace("/", "\\/")
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
				var dict = PokemonList.POKEMON
				if is_id_var:
					if var_string.is_valid_integer():
						return int(var_string)
				elif dict.has(var_string):
					return dict[var_string]["id"]
		return -1

func _ready():
	$EditCollections.text = Consts.SPRITE_COLLECTION_PATH

func _on_ButtonSprites_button_down():
	$DirectoryDialog.visible = true
	$DirectoryDialog.invalidate()

func _on_DirectoryDialog_dir_selected(dir):
	$EditSprites.text = dir

func _on_ButtonImport_button_down():
	if $EditSprites.text == "":
		do_log("Sprite directory not specified!")
		return
	if $EditCollections.text == "":
		do_log("Sprite-Collection directory not specified!")
		return
	
	var files = []
	var patterns = []
	var pattern
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditMaleFrontPattern.text)
	pattern.sprite_id = SpriteCollection.Sprites.Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditFemaleFrontPattern.text)
	pattern.sprite_id = SpriteCollection.Sprites.Female_Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditMaleBackPattern.text)
	pattern.sprite_id = SpriteCollection.Sprites.Back
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelNormalSprites/EditFemaleBackPattern.text)
	pattern.sprite_id = SpriteCollection.Sprites.Female_Back
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditMaleFrontPattern.text)
	pattern.sprite_id = SpriteCollection.Sprites.Shiny_Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditFemaleFrontPattern.text)
	pattern.sprite_id = SpriteCollection.Sprites.Shiny_Female_Front
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditMaleBackPattern.text)
	pattern.sprite_id = SpriteCollection.Sprites.Shiny_Back
	patterns.append(pattern)
	
	pattern = FilePattern.new()
	pattern.create($PanelShinySprites/EditFemaleBackPattern.text)
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
			pkmn_id = pat.is_match(file)
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

func do_log(text: String) -> void:
	$Log.text = $Log.text + text + "\n"
