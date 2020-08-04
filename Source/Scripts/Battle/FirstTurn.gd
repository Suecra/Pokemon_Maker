extends "res://Source/Scripts/Battle/Turn.gd"

const Switch = preload("res://Source/Scripts/Battle/Switch.gd")

func _start() -> void:
	for trainer in trainers:
		var switch = Switch.new()
		switch.trainer = trainer
		switch.pokemon = trainer._get_lead()
		switch.to_pokemon = switch.pokemon
		switch.battle = battle
		switch.battlefield = battle.battlefield
		switch.field = trainer.field
		switch.turn = battle.current_turn
		half_turns.append(switch)
	do_half_turns()
	yield(do_animations(), "completed")
	disconnect_trainers()

func _start_async() -> void:
	for trainer in trainers:
		var switch = Switch.new()
		switch.trainer = trainer
		switch.pokemon = trainer._get_lead()
		switch.to_pokemon = switch.pokemon
		switch.battle = battle
		switch.battlefield = battle.battlefield
		switch.field = trainer.field
		switch.turn = battle.current_turn
		half_turns.append(switch)
	do_half_turns()
	disconnect_trainers()
