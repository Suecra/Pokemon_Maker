extends Node

enum EffectedPokemon {User, Target}

export(EffectedPokemon) var effected_pokemon = 0
export(bool) var guaranteed = true
export(float) var chance = 0.0

var user
var target

func trigger():
	if guaranteed || Utils.trigger(chance):
		if effected_pokemon == EffectedPokemon.User:
			_execute(user)
		elif effected_pokemon == EffectedPokemon.Target:
			if not target.fainted():
				_execute(target)

func _execute(pokemon):
	pass
