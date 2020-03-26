extends CanvasLayer

export(PackedScene) var move_button_style

enum SelectionState {SELECT_OPTION, SELECT_MOVE}

const SEL_CANCEL = -1
const SEL_MOVE_1 = 0
const SEL_MOVE_2 = 1
const SEL_MOVE_3 = 2
const SEL_MOVE_4 = 3
const SEL_MOVE = 4
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

func show_selection():
	state = SelectionState.SELECT_OPTION
	_show_options()

func _show_options():
	pass

func _hide_options():
	pass

func _show_moves():
	pass
	
func _hide_moves():
	pass

func selected(id):
	if state == SelectionState.SELECT_OPTION:
		_hide_options()
		match id:
			SEL_CANCEL: emit_signal("canceled")
			SEL_MOVE:
				if movepool.has_moves_left():
					state = SelectionState.SELECT_MOVE
					_show_moves()
				else:
					emit_signal("move_selected", STRUGGLE)
			SEL_RUN: emit_signal("run_selected")
			SEL_BAG: emit_signal("bag_selected")
			SEL_SWITCH: emit_signal("switch_selected")
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

func move_selected(id):
	var move = movepool.get_move(id)
	if move._can_use():
		_hide_moves()
		emit_signal("move_selected", id)