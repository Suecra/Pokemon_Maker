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

var line_edit: LineEdit
var sprites_dir
var sprite_sheets_dir
var sprite_collections_dir
var sprites_per_row
var generations

func _on_ButtonSpritesheets_button_down():
	line_edit = $EditSpritesheets
	$DirectoryDialog.popup()

func _on_ButtonSpriteCollections_button_down():
	line_edit = $EditSpriteCollections
	$DirectoryDialog.popup()

func _on_ButtonSprite_button_down():
	line_edit = $EditSprites
	$DirectoryDialog.popup()

func _on_DirectoryDialog_dir_selected(dir):
	line_edit.text = dir

func prepare_import():
	sprites_dir = $EditSprites.text
	sprite_sheets_dir = $EditSpritesheets.text
	sprites_dir = $EditSprites.text
	sprites_per_row = $SpinBoxSpritesPerRow.value
	generations = $SpinBoxGenerations.value

func _on_ImportGraphics_button_down():
	prepare_import()
	do_import()

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
		BACK_FOLDER_NAME: result += "back"
		FEMALE_BACK_FOLDER_NAME: result += "female_back"
		SHINY_FEMALE_BACK_FOLDER_NAME: result += "shiny_female_back"
		SHINY_BACK_FOLDER_NAME: result += "shiny_back"
		FRONT_FOLDER_NAME: result += "front"
		FEMALE_FRONT_FOLDER_NAME: result += "female_front"
		SHINY_FEMALE_FRONT_FOLDER_NAME: result += "shiny_female_front"
		SHINY_FRONT_FOLDER_NAME: result += "shiny_front"
	return result

func get_files(directory: Directory, list):
	var item = directory.get_next()
	while item != "":
		if directory.current_is_dir():
			var dir = Directory.new()
			var current_dir = directory.get_current_dir()
			if dir.open(current_dir + "/" + item) == OK:
				dir.list_dir_begin(true, true)
				get_files(dir, list)
				dir.list_dir_end()
		else:
			list.append(directory.get_current_dir() + "/" + item)
		item = directory.get_next()

func do_log(entry):
	$GraphicsLog.text += entry + "\n"
