extends "res://Source/Scripts/Battle/Trainer.gd"

enum State {SELECT_OPTION, SELECT_MOVE, SELECT_POKEMON}

var state

func _do_half_turn():
	set_physics_process(true)
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

func select_option():
	print("Select option [1]Attack [2]Switch [3]Run...")
	state = State.SELECT_OPTION

func select_move():
	print("Select move [1] [2] [3] [4]")
	state = State.SELECT_MOVE

func select_pokemon():
	print("Select pokemon [1] [2] [3] [4] [5] [6]")
	state = State.SELECT_POKEMON