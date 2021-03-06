extends Node

class_name Effect

enum EffectedPokemon {User, Target}

export(EffectedPokemon) var effected_pokemon = 0
export(bool) var guaranteed = true
export(float) var chance = 0.0

var user: Node
var target: Node

func trigger() -> void:
	if guaranteed || Utils.trigger(chance):
		if effected_pokemon == EffectedPokemon.User:
			_execute(user)
		elif effected_pokemon == EffectedPokemon.Target:
			if not target.fainted():
				_execute(target)

func _execute(pokemon: Node) -> void:
	pass

func _save_to_json(data: Dictionary) -> void:
	pass
