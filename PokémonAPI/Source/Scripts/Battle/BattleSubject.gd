extends Node

var battle
var subject_owner
var observables = []

func register(observable, message: String, method: String, priority: int = 1):
	observable.register(self, message, method, priority)
	observables.append(observable)

func get_pokemon_speed():
	return subject_owner.current_speed

func unregister_all():
	for observable in observables:
		observable.unregister_all(self)