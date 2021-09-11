extends "res://Source/Scripts/Battle/Trainer.gd"

const Resign = preload("res://Source/Scripts/Battle/Resign.gd")
const Escape = preload("res://Source/Scripts/Battle/Escape.gd")
const Battle = preload("res://Source/Scripts/Battle/Battle.gd")

var choicebox: Node
var move_selection: Node
var selected_move: Node
var escape: Node

func _do_half_turn() -> void:
	._do_half_turn()
	choicebox = battle.get_node("Choicebox")
	choicebox.cancel = true
	move_selection = battle.get_node("MoveSelection")
	move_selection.connect("move_selected", self, "move_selected")
	move_selection.connect("switch_selected", self, "switch_selected")
	move_selection.connect("bag_selected", self, "bag_selected")
	move_selection.connect("run_selected", self, "run_selected")
	move_selection.movepool = current_pokemon.movepool
	move_selection.show_selection()

func move_selected(index) -> void:
	escape.tries = 0
	emit_signal("choice_made", self, move(index))

func switch_selected() -> void:
	choicebox.connect("selected", self, "pokemon_selected")
	Input.action_release("select|action")
	choicebox.display_async(pokemon_party.get_switch_targets(current_pokemon))
	choicebox.item_index = 1

func bag_selected() -> void:
	var messagebox = battle.get_node("MessageBox")
	yield(messagebox.display("Not implemented yet"), "completed")
	move_selection.show_selection()

func run_selected() -> void:
	var action
	match battle.battle_type:
		Battle.BattleType.WildPokemon:
			action = escape
		Battle.BattleType.Trainer:
			var messagebox = battle.get_node("MessageBox")
			yield(messagebox.display("No! There's no running from a Trainer battle!"), "completed")
			move_selection.show_selection()
			return
		Battle.BattleType.BattleTower:
			action = Resign.new()
	action.trainer = self
	emit_signal("choice_made", self, action)

func _force_switch_in() -> void:
	._force_switch_in()
	if pokemon_party.get_fighter_count() == 1:
		emit_signal("choice_made", self, switch(0))
	else:
		choicebox.cancel = false
		choicebox.connect("selected", self, "option_selected")
		switch_selected()

func pokemon_selected() -> void:
	choicebox.disconnect("selected", self, "pokemon_selected")
	if choicebox.item_index == -1:
		move_selection.show_selection()
	else:
		escape.tries = 0
		emit_signal("choice_made", self, switch(choicebox.item_index))

func _get_switch_in_message() -> String:
	var msg = ""
	var opponent = field.opponent_field.trainers[0].current_pokemon
	if opponent != null && float(opponent.current_hp) / float(opponent.hp) < 0.33:
		var i = randi() % 2
		match i:
			0: msg = "Your foe's weak! Get 'em, " + current_pokemon.nickname
			1: msg = "Just a little more! Hang in there, " + current_pokemon.nickname
	else:
		var i = randi() % 3
		match i:
			0: msg = "Go, " + current_pokemon.nickname + "!"
			1: msg = "You're in charge, " + current_pokemon.nickname + "!"
			2: msg = "Go for it, " + current_pokemon.nickname + "!"
	return msg

func _get_switch_out_message() -> String:
	var msg = ""
	var i = randi() % 5
	match i:
		0: msg = current_pokemon.nickname + ", switch out! Come back!"
		1: msg = current_pokemon.nickname + ", come back!"
		2: msg = current_pokemon.nickname + ", OK! Come back!"
		3: msg = current_pokemon.nickname + ", enough! Get back!"
		4: msg = current_pokemon.nickname + ", good! Come back!"
	return msg

func _init_battle() -> void:
	._init_battle()
	escape = Escape.new()
