extends Node

var battle
var subject_owner
var registered_messages = []

func register(observable, message: String, method: String, priority: int = 1):
	observable.register(self, message, method, priority)
	registered_messages.append(message)

func get_pokemon_speed():
	return subject_owner.current_speed

func unregister_all():
	for message in registered_messages:
		battle.unregister(self, message)