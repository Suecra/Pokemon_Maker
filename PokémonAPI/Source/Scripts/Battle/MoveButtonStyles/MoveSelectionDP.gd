extends "res://Source/Scripts/Battle/MoveSelection.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")

func _show_options():
	$MovePosition1/FightButton.visible = true
	$MovePosition2/SwitchButton.visible = true
	$MovePosition3/BagButton.visible = true
	$MovePosition4/RunButton.visible = true

func _hide_options():
	$MovePosition1/FightButton.visible = false
	$MovePosition2/SwitchButton.visible = false
	$MovePosition3/BagButton.visible = false
	$MovePosition4/RunButton.visible = false

func _show_moves():
	$CancelButton.visible = true
	for i in movepool.get_child_count():
		var parent = get_node("MovePosition" + String(i + 1))
		var style = Utils.unpack(parent, move_button_style, "MoveButton")
		var move = movepool.get_child(i)
		style.move_name = move.get_move_data().move_name
		style.max_pp = move.get_move_data().pp
		style.pp = move.current_pp
		style.type_id = move.get_move_data().get_type().id
		style.move_id = i
		parent.add_child(style)
		style.owner = self
		style.connect("selected", self, "selected")
		move_child(style, 0)

func _hide_moves():
	$CancelButton.visible = false
	var nr: String
	for i in movepool.get_child_count():
		nr = String(i + 1)
		get_node("MovePosition" + nr).remove_child(get_node("MovePosition" + nr + "/MoveButton"))

func _on_CancelButton_button_down():
	selected(SEL_CANCEL)

func _on_FightButton_button_down():
	selected(SEL_MOVE)

func _on_SwitchButton_button_down():
	selected(SEL_SWITCH)

func _on_BagButton_button_down():
	#selected(SEL_BAG)
	pass

func _on_RunButton_button_down():
	selected(SEL_RUN)
