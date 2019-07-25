extends CanvasLayer

const Utils = preload("res://Source/Scripts/Utils.gd")

export(PackedScene) var style

var pokemon

func initialize(pokemon):
	self.pokemon = pokemon
	update()

func update():
	$Style.max_hp = pokemon.hp
	$Style.hp = pokemon.current_hp
	$Style.gender = pokemon.gender
	$Style.level = pokemon.level
	$Style.pokemon_name = pokemon.nickname

func show():
	$Style.visible = true

func hide():
	$Style.visible = false

func get_style():
	return Utils.unpack(self, style, "Style")