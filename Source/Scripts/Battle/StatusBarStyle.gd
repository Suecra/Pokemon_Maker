extends Node2D

enum Gender {Male, Female, Genderless}

var max_hp: int setget set_max_hp
var hp: int setget set_hp
var level: int setget set_level
var pokemon_name: String setget set_pokemon_name
var gender setget set_gender
var status: String setget set_status 

onready var hp_bar_style := $HPBarStyle
onready var level_label := $Level
onready var name_label := $Name
onready var gender_icon := $GenderIcon
onready var status_icon := $StatusIcon

func play_damage_animation(damage: int) -> void:
	yield(hp_bar_style._play_damage_animation(max(hp_bar_style.hp - damage, 0)), "completed")

func set_max_hp(value: int) -> void:
	max_hp = value
	hp_bar_style.max_hp = max_hp

func set_hp(value: int) -> void:
	hp = value
	hp_bar_style.hp = hp

func set_level(value: int) -> void:
	level = value
	level_label.text = str(level)

func set_pokemon_name(value: String) -> void:
	pokemon_name = value
	name_label.text = pokemon_name

func set_gender(value) -> void:
	gender = value
	gender_icon.gender = gender

func set_status(value: String) -> void:
	status = value
	status_icon.status = status
