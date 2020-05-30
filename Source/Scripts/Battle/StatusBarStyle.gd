extends Node2D

enum Gender {Male, Female, Genderless}

var max_hp: int setget set_max_hp
var hp: int setget set_hp
var level: int setget set_level
var pokemon_name: String setget set_pokemon_name
var gender setget set_gender
var status: String setget set_status 

func play_damage_animation(damage):
	yield($HPBarStyle._play_damage_animation(max($HPBarStyle.hp - damage, 0)), "completed")

func set_max_hp(value):
	max_hp = value
	$HPBarStyle.max_hp = max_hp

func set_hp(value):
	hp = value
	$HPBarStyle.hp = hp

func set_level(value):
	level = value
	$Level.text = str(level)

func set_pokemon_name(value):
	pokemon_name = value
	$Name.text = pokemon_name

func set_gender(value):
	gender = value
	$GenderIcon.gender = gender

func set_status(value):
	status = value
	$StatusIcon.status = status
