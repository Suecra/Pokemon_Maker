extends "res://Source/Scripts/Battle/Turn.gd"

const Switch = preload("res://Source/Scripts/Battle/Switch.gd")

func _start():
	for t in trainers:
		var switch = Switch.new()
		switch.trainer = t
		switch.pokemon = t._get_lead()
		switch.to_pokemon = switch.pokemon
		switch.battle = battle
		switch.battlefield = battle.battlefield
		switch.field = t.field
		half_turns.append(switch)
	do_half_turns()
	yield(do_actions(), "completed")
	disconnect_trainers()
