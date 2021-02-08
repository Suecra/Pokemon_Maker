extends Node2D

enum Gender {Male, Female, Genderless}

var pokemon_name: String setget set_pokemon_name
var level: int setget set_level
var hp: int setget set_hp
var max_hp: int setget set_max_hp
var gender: int setget set_gender
var status: String setget set_status

signal animation_finished

func set_hp_no_anim(value: int) -> void:
	if value != hp:
		hp = value
		_update_hp()

func set_hp(value: int) -> void:
	if value != hp:
		var old_hp = hp
		hp = value
		_animate_hp(old_hp)

func set_max_hp(value: int) -> void:
	if value != max_hp:
		max_hp = value
		_update_max_hp()

func set_level(value: int) -> void:
	if level != value:
		level = value
		_update_level()

func set_pokemon_name(value: String) -> void:
	if pokemon_name != value:
		pokemon_name = value
		_update_pokemon_name()

func set_gender(value: int) -> void:
	if gender != value:
		gender = value
		_update_gender()

func set_status(value: String) -> void:
	if status != value:
		status = value
		_update_status()

func _update_hp() -> void:
	pass

func _update_max_hp() -> void:
	pass

func _animate_hp(old_hp: int) -> void:
	pass

func _update_level() -> void:
	pass

func _update_pokemon_name() -> void:
	pass

func _update_gender() -> void:
	pass

func _update_status() -> void:
	pass

func _show() -> void:
	visible = true

func _hide() -> void:
	visible = false
	
func full_update(pokemon) -> void:
	set_hp_no_anim(pokemon.current_hp)
	self.max_hp = pokemon.hp
	
	self.pokemon_name = pokemon.nickname
	self.level = pokemon.level
	self.gender = pokemon.gender
	self.status = pokemon.get_primary_status_name()

func finish_animation() -> void:
	emit_signal("animation_finished")
