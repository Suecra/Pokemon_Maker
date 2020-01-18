extends Object

var priority
var subject
var method

func get_pokemon_speed():
	return subject._get_priority()

func same_priority(other_subject):
	return priority == other_subject.priority && get_pokemon_speed() == other_subject.get_pokemon_speed()

func notify(args = null):
	subject.call(method, args)