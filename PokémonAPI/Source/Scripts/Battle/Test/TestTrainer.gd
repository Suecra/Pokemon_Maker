extends "res://Source/Scripts/Battle/Trainer.gd"

enum State {SELECT_OPTION, SELECT_MOVE, SELECT_POKEMON}

var state
var choicebox

func _do_half_turn():
	choicebox = battle.get_node("Choicebox")
	choicebox.connect("selected", self, "option_selected")
	select_option()

func _physics_process(delta):
	if Input.is_action_just_pressed("debug_1"):
		if state == State.SELECT_OPTION:
			select_move()
		elif state == State.SELECT_MOVE:
			emit_signal("choice_made", self, move(0))
			set_physics_process(false)
		elif state == State.SELECT_POKEMON:
			emit_signal("choice_made", self, switch(0))
			set_physics_process(false)
	elif Input.is_action_just_pressed("debug_2"):
		if state == State.SELECT_OPTION:
			select_pokemon()
		elif state == State.SELECT_MOVE:
			emit_signal("choice_made", self, move(1))
			set_physics_process(false)
		elif state == State.SELECT_POKEMON:
			emit_signal("choice_made", self, switch(1))
			set_physics_process(false)
	elif Input.is_action_just_pressed("debug_3"):
		if state == State.SELECT_OPTION:
			pass
		elif state == State.SELECT_MOVE:
			emit_signal("choice_made", self, move(2))
			set_physics_process(false)
		elif state == State.SELECT_POKEMON:
			emit_signal("choice_made", self, switch(2))
			set_physics_process(false)
	elif Input.is_action_just_pressed("debug_4"):
		if state == State.SELECT_MOVE:
			emit_signal("choice_made", self, move(3))
			set_physics_process(false)
		elif state == State.SELECT_POKEMON:
			emit_signal("choice_made", self, switch(3))
			set_physics_process(false)
	elif Input.is_action_just_pressed("debug_5"):
		if state == State.SELECT_POKEMON:
			emit_signal("choice_made", self, switch(4))
			set_physics_process(false)
	elif Input.is_action_just_pressed("debug_6"):
		if state == State.SELECT_POKEMON:
			emit_signal("choice_made", self, switch(5))
			set_physics_process(false)

func option_selected():
	if state == State.SELECT_OPTION:
		match choicebox.item_index:
			0: select_move()
			1: select_pokemon()
	elif state == State.SELECT_MOVE:
		choicebox.disconnect("selected", self, "option_selected")
		emit_signal("choice_made", self, move(choicebox.item_index))
	elif state == State.SELECT_POKEMON:
		choicebox.disconnect("selected", self, "option_selected")
		emit_signal("choice_made", self, switch(choicebox.item_index))

func select_option():
	battle.get_node("MessageBox").display_async("What will 'Player' do?")
	choicebox.display_async(["Attack", "Switch", "Run"])
	state = State.SELECT_OPTION

func select_move():
	choicebox.display_async(current_pokemon.get_movepool().to_string_array())
	state = State.SELECT_MOVE

func select_pokemon():
	choicebox.display_async(pokemon_party.to_string_array_battler())
	state = State.SELECT_POKEMON

func _force_switch_in():
	choicebox.connect("selected", self, "option_selected")
	select_pokemon()
	pass