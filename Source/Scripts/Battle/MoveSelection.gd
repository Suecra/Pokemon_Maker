extends CanvasLayer

enum SelectionState {SELECT_OPTION, SELECT_MOVE, NONE}

const SEL_CANCEL = -1
const SEL_MOVE_1 = 0
const SEL_MOVE_2 = 1
const SEL_MOVE_3 = 2
const SEL_MOVE_4 = 3
const SEL_FIGHT = 4
const SEL_RUN = 5
const SEL_BAG = 6
const SEL_SWITCH = 7
const STRUGGLE = -1

signal move_selected
signal switch_selected
signal bag_selected
signal run_selected
signal canceled

var movepool
var state

func show_selection() -> void:
	state = SelectionState.SELECT_OPTION
	_show_options()

func _show_options() -> void:
	pass

func _hide_options() -> void:
	pass

func _show_moves() -> void:
	pass
	
func _hide_moves() -> void:
	pass

func selected(id: int) -> void:
	if state == SelectionState.SELECT_OPTION:
		match id:
			SEL_FIGHT:
				_hide_options()
				if movepool.has_moves_left():
					state = SelectionState.SELECT_MOVE
					_show_moves()
				else:
					state = SelectionState.NONE
					emit_signal("move_selected", STRUGGLE)
			SEL_RUN: notify("run_selected")
			SEL_BAG: notify("bag_selected")
			SEL_SWITCH: notify("switch_selected")
	elif state == SelectionState.SELECT_MOVE:
		match id:
			SEL_CANCEL:
				_hide_moves()
				state = SelectionState.SELECT_OPTION
				_show_options()
			SEL_MOVE_1: move_selected(0)
			SEL_MOVE_2: move_selected(1)
			SEL_MOVE_3: move_selected(2)
			SEL_MOVE_4: move_selected(3)

func move_selected(id: int):
	var move = movepool.get_move(id)
	if move._can_use():
		_hide_moves()
		state = SelectionState.NONE
		emit_signal("move_selected", id)

func notify(choice: String) -> void:
	_hide_options()
	state = SelectionState.NONE
	emit_signal(choice)
