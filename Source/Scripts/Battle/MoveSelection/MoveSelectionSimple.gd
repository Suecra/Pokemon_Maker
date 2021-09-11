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
var option_index: int
var index: int

func _show_options() -> void:
	index = option_index
	
	button1.text = "Fight"
	button2.text = "Switch"
	button3.text = "Bag"
	button4.text = "Run"
	
	button1.color = fight_color
	button2.color = switch_color
	button3.color = bag_color
	button4.color = run_color
	
	for btn in buttons:
		btn.bottom_text = ""
		btn.right_text = ""
		btn.show()
	highlight_button()

func _hide_options() -> void:
	for btn in buttons:
		btn.hide()

func _show_moves() -> void:
	option_index = index
	index = 0
	
	for btn in buttons:
		btn.text = ""
		btn.bottom_text = ""
		btn.right_text = ""
		btn.color = Color.white
	
	for i in range(movepool.count()):
		buttons[i].text = movepool.get_move(i).data.move_name.capitalize()
		buttons[i].bottom_text = movepool.get_move(i).data.get_type().type_name
		buttons[i].color = get_type_color(movepool.get_move(i).data.get_type().id)
		var pp = movepool.get_move(i).current_pp
		var max_pp = movepool.get_move(i).data.pp
		buttons[i].right_text = str(pp) + "/" + str(max_pp)
	
	for btn in buttons:
		btn.show()
	highlight_button()

func _hide_moves() -> void:
	for btn in buttons:
		btn.hide()

func get_type_color(id: int) -> Color:
	match id:
		Type.Types.NORMAL: return Color("#DDCCCC")
		Type.Types.FIGHTING: return Color("#DD9988")
		Type.Types.FLYING: return Color("#99BBFF")
		Type.Types.POISON: return Color("#CC88BB")
		Type.Types.GROUND: return Color("#EFCD9A")
		Type.Types.ROCK: return Color("#DDCC99")
		Type.Types.BUG: return Color("#CCDD66")
		Type.Types.GHOST: return Color("#9999CC")
		Type.Types.STEEL: return Color("#CCCCCC")
		Type.Types.FIRE: return Color("#FF8877")
		Type.Types.WATER: return Color("#77BBFF")
		Type.Types.GRASS: return Color("#ABDE8A")
		Type.Types.ELECTRIC: return Color("#FFDD77")
		Type.Types.PSYCHIC: return Color("#FF99BB")
		Type.Types.ICE: return Color("#B5E8F4")
		Type.Types.DRAGON: return Color("#AA99EE")
		Type.Types.DARK: return Color("#AA9988")
		Type.Types.FAIRY: return Color("#FFCCFF")
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
	elif state == SelectionState.SELECT_MOVE:
		if sender == button1:
			selected(SEL_MOVE_1)
		if sender == button2:
			selected(SEL_MOVE_2)
		if sender == button3:
			selected(SEL_MOVE_3)
		if sender == button4:
			selected(SEL_MOVE_4)

func button_hovered(sender: Node) -> void:
	index = buttons.find(sender)
	highlight_button()

func highlight_button() -> void:
	for btn in buttons:
		btn.scale = Vector2(1, 1)
		btn.modulate = Color.white
	buttons[index].scale = Vector2(1.2, 1.2)
	buttons[index].modulate = Color.lightblue

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("run|back"):
		selected(SEL_CANCEL)
	if Input.is_action_just_pressed("move_up"):
		index = max(0, index - 1)
		highlight_button()
	if Input.is_action_just_pressed("move_down"):
		index = min(3, index + 1)
		highlight_button()
	if Input.is_action_just_pressed("select|action"):
		button_pressed(buttons[index])

func _ready() -> void:
	index = 0
	option_index = index
	for btn in buttons:
		btn.connect("pressed", self, "button_pressed")
		btn.connect("hovered", self, "button_hovered")
