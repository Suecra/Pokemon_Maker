extends Object

var priority
var subject
var method

func get_pokemon_speed():
	return subject.get_pokemon_speed()

func notify():
	subject.call(method)