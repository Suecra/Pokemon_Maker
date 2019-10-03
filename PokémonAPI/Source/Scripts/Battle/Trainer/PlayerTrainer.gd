extends "res://Source/Scripts/Battle/Trainer.gd"

var choicebox
var move_selection

func _do_half_turn():
	choicebox = battle.get_node("Choicebox")
	move_selection = battle.get_node("MoveSelection")
	move_selection.connect("move_selected", self, "move_selected")
	move_selection.connect("switch_selected", self, "switch_selected")
	battle.get_node("MessageBox").display_async("What will 'Player' do?")
	move_selection.movepool = current_pokemon.get_movepool()
	move_selection.show_selection()

func move_selected(index):
	emit_signal("choice_made", self, move(index))

func switch_selected():
	choicebox.connect("selected", self, "pokemon_selected")
	Input.action_release("ui_accept")
	choicebox.display_async(pokemon_party.to_string_array_battler())
	choicebox.item_index = 1

func _force_switch_in():
	choicebox.connect("selected", self, "option_selected")
	switch_selected()

func pokemon_selected():
	choicebox.disconnect("selected", self, "pokemon_selected")
	emit_signal("choice_made", self, switch(choicebox.item_index))