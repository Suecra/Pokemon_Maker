extends CanvasLayer

const Utils = preload("res://Source/Scripts/Utils.gd")

export(PackedScene) var style

var pokemon

func initialize(pokemon):
	self.pokemon = pokemon
	update()

func update_hp():
	$Style.max_hp = pokemon.hp
	$Style.hp = pokemon.current_hp

func update_gender():
	$Style.gender = pokemon.gender

func update_level():
	$Style.level = pokemon.level

func update_pokemon_name():
	$Style.pokemon_name = pokemon.nickname

func update_status():
	var status = pokemon.get_status()
	if status == null:
		$Style.status = ""
	else:
		$Style.status = status.status_name

func update():
	update_hp()
	update_gender()
	update_level()
	update_pokemon_name()
	update_status()

func animate_damage(damage):
	yield($Style.play_damage_animation(damage), "completed")

func show():
	$Style.visible = true

func hide():
	$Style.visible = false

func get_style():
	return Utils.unpack(self, style, "Style")