extends "res://Source/Scripts/Battle/MoveSelection.gd"

const Type = preload("res://Source/Data/Type.gd")

export(Color) var fight_color
export(Color) var switch_color
export(Color) var bag_color
export(Color) var run_color

onready var button1 := $Button1
onready var button2 := $Button2
onready var button3 := $Button3
onready var button4 := $Button4

onready var buttons := [button1, button2, button3, button4]

func _show_options() -> void:
	button1.text = "Fight"
	button2.text = "Switch"
	button3.text = "Bag"
	button4.text = "Run"
	
	button1.color = fight_color
	button2.color = switch_color
	button3.color = bag_color
	button4.color = run_color
	
	for btn in buttons:
		btn.show()

func _hide_options() -> void:
	for btn in buttons:
		btn.hide()

func _show_moves() -> void:
	for btn in buttons:
		btn.text = ""
		btn.bottom_text = ""
		btn.right_text = ""
		btn.color = Color.white
	
	for i in range(movepool.count()):
		buttons[i].text = movepool.get_move(i).data.move_name
		buttons[i].bottom_text = movepool.get_move(i).data.get_type().type_name
		buttons[i].color = get_type_color(movepool.get_move(i).data.get_type().id)
		var pp = movepool.get_move(i).current_pp
		var max_pp = movepool.get_move(i).data.pp
		buttons[i].right_text = str(pp) + "/" + str(max_pp)
	
	for btn in buttons:
		btn.show()

func _hide_moves() -> void:
	for btn in buttons:
		btn.hide()

func get_type_color(id: int) -> Color:
	match id:
		Type.Types.NORMAL: return Color.gray
	return Color.white

func button_pressed(sender: Node) -> void:
	if state == SelectionState.SELECT_OPTION:
		if sender == button1:
			selected(SEL_FIGHT)
		if sender == button2:
			selected(SEL_SWITCH)
		if sender == button3:
			selected(SEL_BAG)
		if sender == button4:
			selected(SEL_RUN)
	else:
		if sender == button1:
			selected(SEL_MOVE_1)
		if sender == button2:
			selected(SEL_MOVE_2)
		if sender == button3:
			selected(SEL_MOVE_3)
		if sender == button4:
			selected(SEL_MOVE_4)

func _ready() -> void:
	for btn in buttons:
		btn.connect("pressed", self, "button_pressed")
