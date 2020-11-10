extends Tabs

const PokemonSpriteCollection = preload("res://Source/Scripts/Common/PokemonSpriteCollection.gd")
const PokemonSpriteBW = preload("res://Source/Scripts/Common/PokemonSpriteBW.gd")

const BACK_FOLDER_NAME = "Back"
const FEMALE_BACK_FOLDER_NAME = "Back - Female"
const SHINY_FEMALE_BACK_FOLDER_NAME = "Back - Female - Shiny"
const SHINY_BACK_FOLDER_NAME = "Back - Shiny"
const FRONT_FOLDER_NAME = "Front"
const FEMALE_FRONT_FOLDER_NAME = "Front - Female"
const SHINY_FEMALE_FRONT_FOLDER_NAME = "Front - Female - Shiny"
const SHINY_FRONT_FOLDER_NAME = "Front-Shiny"

const BACK_SPRITE_NAME = "back"
const FEMALE_BACK_SPRITE_NAME = "female_back"
const SHINY_FEMALE_BACK_SPRITE_NAME = "shiny_female_back"
const SHINY_BACK_SPRITE_NAME = "shiny_back"
const FRONT_SPRITE_NAME = "front"
const FEMALE_FRONT_SPRITE_NAME = "female_front"
const SHINY_FEMALE_FRONT_SPRITE_NAME = "shiny_female_front"
const SHINY_FRONT_SPRITE_NAME = "shiny_front"

enum Gender {All, Male, Female}
enum View {All, Front, Back}
enum Appearance {All, Normal, Shiny}

var line_edit: LineEdit
var sprites_dir
var sprite_sheets_dir
var sprite_collections_dir
var pokemon_dir
var generations: int
var gender
var view
var appearance

func _on_ButtonSpritesheets_button_down():
	line_edit = $EditSpritesheets
	$DirectoryDialog.popup()

func _on_ButtonSpriteCollections_button_down():
	line_edit = $EditSpriteCollections
	$DirectoryDialog.popup()

func _on_ButtonSprite_button_down():
	line_edit = $EditSprites
	$DirectoryDialog.popup()

func _on_ButtonPokemon_button_down():
	line_edit = $EditPokemon
	$DirectoryDialog.popup()

func _on_DirectoryDialog_dir_selected(dir):
	line_edit.text = dir

func prepare_import():
	sprites_dir = $EditSprites.text
	sprite_sheets_dir = $EditSpritesheets.text
	sprite_collections_dir = $EditSpriteCollections.text
	sprites_dir = $EditSprites.text
	pokemon_dir = $EditPokemon.text
	gender = $ButtonGender.selected
	view = $ButtonView.selected
	appearance = $ButtonAppearance.selected
	generations = 0
	generations += int($CheckBoxGen1.pressed)
	generations += int($CheckBoxGen2.pressed) * 2
	generations += int($CheckBoxGen3.pressed) * pow(2, 2)
	generations += int($CheckBoxGen4.pressed) * pow(2, 3)
	generations += int($CheckBoxGen5.pressed) * pow(2, 4)
	generations += int($CheckBoxGen6.pressed) * pow(2, 5)
	generations += int($CheckBoxGen7.pressed) * pow(2, 6)

func _on_ImportGraphics_button_down():
	prepare_import()
	import_sprite_collections()
	#do_import()

func do_import():
	var directory = Directory.new()
	var files = []
	var f
	var sprite: PokemonSpriteBW
	var scene
	var pokemon_sprite: Sprite
	var animation_player
	var animation
	if directory.open(sprite_sheets_dir) == OK:
		directory.list_dir_begin(true, true)
		get_files(directory, files)
		directory.list_dir_end()
	for i in files.size() - 1:
		f = files[i]
		if f.ends_with(".png"):
			do_log("importing " + f + "...")
			sprite = PokemonSpriteBW.new()
			sprite.name = generate_name(f)
			add_child(sprite)
			
			pokemon_sprite = Sprite.new()
			pokemon_sprite.name = "Sprite"
			pokemon_sprite.texture = load(f)
			sprite.add_child(pokemon_sprite)
			pokemon_sprite.scale = Vector2(3, 3)
			pokemon_sprite.owner = sprite
			
			animation_player = AnimationPlayer.new()
			animation_player.name = "AnimationPlayer"
			sprite.add_child(animation_player)
			animation_player.owner = sprite
		elif f.ends_with(".txt"):
			var width
			var height
			var frames
			var file = File.new()
			file.open(f, 1)
			width = int(file.get_line())
			height = int(file.get_line())
			frames = int(file.get_line())
			pokemon_sprite.hframes = int(pokemon_sprite.texture.get_width() / width)
			pokemon_sprite.vframes = int(pokemon_sprite.texture.get_height() / height)
			pokemon_sprite.frame = 0
			
			animation = Animation.new()
			animation.length = float(frames) / 10
			animation.loop = true
			animation.add_track(0)
			animation.track_set_path(0, "Sprite:frame")
			for i in range(frames):
				animation.track_insert_key(0, float(i) / 10, i)
			animation.value_track_set_update_mode(0, Animation.UPDATE_DISCRETE)
			animation_player.add_animation("anim", animation)
			
			scene = PackedScene.new()
			scene.pack(sprite)
			ResourceSaver.save(sprites_dir + "/" + sprite.name + ".tscn", scene)
			remove_child(sprite)
			sprite.free()
		$ProgressBar.value = (i / files.size() * 100)
		yield(get_tree().create_timer(0.0), "timeout")

func import_sprite_collections():
	var dir = Directory.new()
	if dir.open(pokemon_dir) == OK:
		dir.list_dir_begin(true, true)
		var item = dir.get_next()
		while item != "":
			if not dir.current_is_dir():
				var pokemon_scene = load(pokemon_dir + "/" + item)
				if pokemon_scene != null:
					var pokemon = pokemon_scene.instance()
					var scene = PackedScene.new()
					add_child(pokemon)
					import_sprite_collection(pokemon)
					scene.pack(pokemon)
					ResourceSaver.save(pokemon_dir + "/" + item, scene)
					remove_child(pokemon)
			item = dir.get_next()
		dir.list_dir_end()

func import_sprite_collection(pokemon):
	var result = []
	var sprite_collection = PokemonSpriteCollection.new()
	var scene = PackedScene.new()
	add_child(sprite_collection)
	var base_name: String
	var dex_nr = str(pokemon.national_dex_nr)
	while dex_nr.length() < 4:
		dex_nr = "0" + dex_nr
	base_name = sprites_dir + "/" + dex_nr + "_"
	sprite_collection.back_sprite = import_if_exists(base_name + BACK_SPRITE_NAME + ".tscn")
	sprite_collection.female_back_sprite = import_if_exists(base_name + FEMALE_BACK_SPRITE_NAME + ".tscn")
	sprite_collection.shiny_female_back_sprite = import_if_exists(base_name + SHINY_FEMALE_BACK_SPRITE_NAME + ".tscn")
	sprite_collection.shiny_back_sprite = import_if_exists(base_name + SHINY_BACK_SPRITE_NAME + ".tscn")
	sprite_collection.front_sprite = import_if_exists(base_name + FRONT_SPRITE_NAME + ".tscn")
	sprite_collection.female_front_sprite = import_if_exists(base_name + FEMALE_FRONT_SPRITE_NAME + ".tscn")
	sprite_collection.shiny_female_front_sprite = import_if_exists(base_name + SHINY_FEMALE_FRONT_SPRITE_NAME + ".tscn")
	sprite_collection.shiny_front_sprite = import_if_exists(base_name + SHINY_FRONT_SPRITE_NAME + ".tscn")
	sprite_collection.name = dex_nr
	scene.pack(sprite_collection)
	ResourceSaver.save(sprite_collections_dir + "/" + sprite_collection.name + ".tscn", scene)
	pokemon.sprite_collection = scene
	remove_child(sprite_collection)

func import_if_exists(filename):
	if ResourceLoader.exists(filename):
		return load(filename)
	return null

func generate_name(filename):
	var f_name
	var path
	var pre_folder_name
	var dummy_f_name
	var result
	f_name = filename.get_file()
	f_name.erase(f_name.length() - 4, 4)
	path = filename.get_base_dir()
	dummy_f_name = path + ".t"
	pre_folder_name = dummy_f_name.get_file()
	pre_folder_name.erase(pre_folder_name.length() - 2, 2)
	result = "0" + f_name.substr(0, 3) + "_"
	match pre_folder_name:
		BACK_FOLDER_NAME: result += BACK_SPRITE_NAME
		FEMALE_BACK_FOLDER_NAME: result += FEMALE_BACK_SPRITE_NAME
		SHINY_FEMALE_BACK_FOLDER_NAME: result += SHINY_FEMALE_BACK_SPRITE_NAME
		SHINY_BACK_FOLDER_NAME: result += SHINY_BACK_SPRITE_NAME
		FRONT_FOLDER_NAME: result += FRONT_SPRITE_NAME
		FEMALE_FRONT_FOLDER_NAME: result += FEMALE_FRONT_SPRITE_NAME
		SHINY_FEMALE_FRONT_FOLDER_NAME: result += SHINY_FEMALE_FRONT_SPRITE_NAME
		SHINY_FRONT_FOLDER_NAME: result += SHINY_FRONT_SPRITE_NAME
	return result

func get_files(directory: Directory, list):
	var item = directory.get_next()
	while item != "":
		if directory.current_is_dir():
			if should_import_dir(item):
				var dir = Directory.new()
				var current_dir = directory.get_current_dir()
				if dir.open(current_dir + "/" + item) == OK:
					dir.list_dir_begin(true, true)
					get_files(dir, list)
					dir.list_dir_end()
		else:
			list.append(directory.get_current_dir() + "/" + item)
		item = directory.get_next()

func should_import_dir(dir_name):
	if dir_name == "GEN 1" && generations & 1 != 1:
		return false
	if dir_name == "GEN 2" && generations & 2 != 2:
		return false
	if dir_name == "GEN 3" && generations & 4 != 4:
		return false
	if dir_name == "GEN 4" && generations & 8 != 8:
		return false
	if dir_name == "GEN 5" && generations & 16 != 16:
		return false
	if dir_name == "GEN 6" && generations & 32 != 32:
		return false
	if dir_name == "GEN 7" && generations & 64 != 64:
		return false
	
	if view == View.Front:
		if dir_name == BACK_FOLDER_NAME || dir_name == FEMALE_BACK_FOLDER_NAME || dir_name == SHINY_FEMALE_BACK_FOLDER_NAME || dir_name == SHINY_BACK_FOLDER_NAME:
			return false
	if view == View.Back:
		if dir_name == FRONT_FOLDER_NAME || dir_name == FEMALE_FRONT_FOLDER_NAME || dir_name == SHINY_FEMALE_FRONT_FOLDER_NAME || dir_name == SHINY_FRONT_FOLDER_NAME:
			return false
	if gender == Gender.Male:
		if dir_name == FEMALE_BACK_FOLDER_NAME || dir_name == SHINY_FEMALE_BACK_FOLDER_NAME || dir_name == FEMALE_FRONT_FOLDER_NAME || dir_name == SHINY_FEMALE_FRONT_FOLDER_NAME:
			return false
	if gender == Gender.Female:
		if dir_name == BACK_FOLDER_NAME || dir_name == SHINY_BACK_FOLDER_NAME || dir_name == FRONT_FOLDER_NAME || dir_name == SHINY_FRONT_FOLDER_NAME:
			return false
	if appearance == Appearance.Normal:
		if dir_name == SHINY_BACK_FOLDER_NAME || dir_name == SHINY_FRONT_FOLDER_NAME || dir_name == SHINY_FEMALE_BACK_FOLDER_NAME || dir_name == SHINY_FEMALE_FRONT_FOLDER_NAME:
			return false
	if appearance == Appearance.Shiny:
		if dir_name == BACK_FOLDER_NAME || dir_name == FRONT_FOLDER_NAME || dir_name == FEMALE_BACK_FOLDER_NAME || dir_name == FEMALE_FRONT_FOLDER_NAME:
			return false
	return true

func do_log(entry):
	$GraphicsLog.text += entry + "\n"
