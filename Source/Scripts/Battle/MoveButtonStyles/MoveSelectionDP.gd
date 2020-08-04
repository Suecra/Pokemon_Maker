extends "res://Source/Scripts/Battle/MoveSelection.gd"

onready var fight_button := $MovePosition1/FightButton
onready var switch_button := $MovePosition2/SwitchButton
onready var bag_button := $MovePosition3/BagButton
onready var run_button := $MovePosition4/RunButton
onready var cancel_button := $CancelButton

func _show_options() -> void:
	fight_button.visible = true
	switch_button.visible = true
	bag_button.visible = true
	run_button.visible = true

func _hide_options() -> void:
	fight_button.visible = false
	switch_button.visible = false
	bag_button.visible = false
	run_button.visible = false

func _show_moves() -> void:
	cancel_button.visible = true
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

func _hide_moves() -> void:
	cancel_button.visible = false
	var nr: String
	for i in movepool.get_child_count():
		nr = String(i + 1)
		get_node("MovePosition" + nr).remove_child(get_node("MovePosition" + nr + "/MoveButton"))

func _on_CancelButton_button_down() -> void:
	selected(SEL_CANCEL)

func _on_FightButton_button_down() -> void:
	selected(SEL_MOVE)

func _on_SwitchButton_button_down() -> void:
	selected(SEL_SWITCH)

func _on_BagButton_button_down() -> void:
	pass

func _on_RunButton_button_down() -> void:
	selected(SEL_RUN)
