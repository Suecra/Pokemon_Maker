extends "res://Source/Scripts/Battle/Trainer.gd"

const Resign = preload("res://Source/Scripts/Battle/Resign.gd")
const Escape = preload("res://Source/Scripts/Battle/Escape.gd")
const Battle = preload("res://Source/Scripts/Battle/Battle.gd")

var choicebox: Node
var move_selection: Node
var selected_move: Node
var escape: Node

func _do_half_turn() -> void:
	choicebox = battle.get_node("Choicebox")
	choicebox.cancel = true
	move_selection = battle.get_node("MoveSelection")
	move_selection.connect("move_selected", self, "move_selected")
	move_selection.connect("switch_selected", self, "switch_selected")
	move_selection.connect("bag_selected", self, "bag_selected")
	move_selection.connect("run_selected", self, "run_selected")
	#battle.get_node("MessageBox").display_async("What will 'Player' do?")
	move_selection.movepool = current_pokemon.movepool
	move_selection.show_selection()

func move_selected(index) -> void:
	escape.tries = 0
	emit_signal("choice_made", self, move(index))

func switch_selected() -> void:
	choicebox.connect("selected", self, "pokemon_selected")
	Input.action_release("ui_accept")
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
			yield(messagebox.display("You can't escape in a trainer-battle!"), "completed")
			move_selection.show_selection()
			return
		Battle.BattleType.BattleTower:
			action = Resign.new()
	action.trainer = self
	emit_signal("choice_made", self, action)

func _force_switch_in() -> void:
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
	return "Go, " + current_pokemon.nickname + "!"

func _get_switch_out_message() -> String:
	return "Enough, " + current_pokemon.nickname + "! Come back!"

func _init_battle() -> void:
	._init_battle()
	escape = Escape.new()
