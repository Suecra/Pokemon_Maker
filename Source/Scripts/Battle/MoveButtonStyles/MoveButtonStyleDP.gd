extends "res://Source/Scripts/Battle/MoveButtonStyle.gd"

func _set_move_name(value):
	$MoveName.text = value

func _set_type_id(value):
	match value:
		Types.NORMAL: $MoveButtons.frame = 8
		Types.FIGHTING: $MoveButtons.frame = 4
		Types.FLYING: $MoveButtons.frame = 16
		Types.POISON: $MoveButtons.frame = 9
		Types.GROUND: $MoveButtons.frame = 0
		Types.ROCK: $MoveButtons.frame = 13
		Types.BUG: $MoveButtons.frame = 3
		Types.GHOST: $MoveButtons.frame = 2
		Types.STEEL: $MoveButtons.frame = 12
		Types.FIRE: $MoveButtons.frame = 17
		Types.WATER: $MoveButtons.frame = 1
		Types.GRASS: $MoveButtons.frame = 6
		Types.ELECTRIC: $MoveButtons.frame = 10
		Types.PSYCHIC: $MoveButtons.frame = 5
		Types.ICE: $MoveButtons.frame = 18
		Types.DRAGON: $MoveButtons.frame = 14
		Types.DARK: $MoveButtons.frame = 7
		Types.UNKNOWN: $MoveButtons.frame = 11

func _set_max_pp(value):
	$MaxPP.text = String(value)

func _set_pp(value):
	$PP.text = String(value)

func _on_Button_button_down():
	emit_signal("selected", move_id)
