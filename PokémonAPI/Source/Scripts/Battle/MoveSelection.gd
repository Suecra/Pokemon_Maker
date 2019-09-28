extends CanvasLayer

const MOVE_1_POSITION = Vector2(500, 400)
const MOVE_2_POSITION = Vector2(750, 400)
const MOVE_3_POSITION = Vector2(500, 500)
const MOVE_4_POSITION = Vector2(750, 500)

export(PackedScene) var button_style

signal move_selected

func show_moves(movepool):
	for i in movepool.get_child_count():
		var style = button_style.instance()
		var move = movepool.get_child(i)
		match i:
			0: style.position = MOVE_1_POSITION
			1: style.position = MOVE_2_POSITION
			2: style.position = MOVE_3_POSITION
			3: style.position = MOVE_4_POSITION
		style.move_name = move.get_move_data().move_name
		style.max_pp = move.get_move_data().pp
		style.pp = move.current_pp
		style.type_id = move.get_move_data().get_type().id
		style.move_id = i
		add_child(style)
		style.owner = self
		style.connect("selected", self, "selected")
		move_child(style, 0)
	pass

func hide_moves():
	while get_child_count() > 0:
		remove_child(get_child(0))

func selected(move_id):
	hide_moves()
	emit_signal("move_selected", move_id)