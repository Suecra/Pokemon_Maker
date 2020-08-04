extends Object

var priority: int
var subject: Node
var method: String

func get_pokemon_speed() -> int:
	return subject._get_priority()

func same_priority(other_subject) -> bool:
	return priority == other_subject.priority && get_pokemon_speed() == other_subject.get_pokemon_speed()

func notify(args = null) -> void:
	if args == null:
		subject.call(method)
	else:
		subject.call(method, args)
