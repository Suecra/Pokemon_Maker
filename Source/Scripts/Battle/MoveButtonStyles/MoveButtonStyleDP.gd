extends "res://Source/Scripts/Battle/MoveButtonStyle.gd"

onready var move_name_label = $MoveName
onready var move_buttons = $MoveButtons
onready var max_pp_label = $MaxPP
onready var pp_label = $PP

func _set_move_name(value: String) -> void:
	move_name_label.text = value

func _set_type_id(value: int) -> void:
	match value:
		Types.NORMAL: move_buttons.frame = 8
		Types.FIGHTING: move_buttons.frame = 4
		Types.FLYING: move_buttons.frame = 16
		Types.POISON: move_buttons.frame = 9
		Types.GROUND: move_buttons.frame = 0
		Types.ROCK: move_buttons.frame = 13
		Types.BUG: move_buttons.frame = 3
		Types.GHOST: move_buttons.frame = 2
		Types.STEEL: move_buttons.frame = 12
		Types.FIRE: move_buttons.frame = 17
		Types.WATER: move_buttons.frame = 1
		Types.GRASS: move_buttons.frame = 6
		Types.ELECTRIC: move_buttons.frame = 10
		Types.PSYCHIC: move_buttons.frame = 5
		Types.ICE: move_buttons.frame = 18
		Types.DRAGON: move_buttons.frame = 14
		Types.DARK: move_buttons.frame = 7
		Types.UNKNOWN: move_buttons.frame = 11

func _set_max_pp(value: int) -> void:
	max_pp_label.text = String(value)

func _set_pp(value: int) -> void:
	pp_label.text = String(value)

func _on_Button_button_down() -> void:
	emit_signal("selected", move_id)
