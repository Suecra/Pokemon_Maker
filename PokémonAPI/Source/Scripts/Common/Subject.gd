extends Node

var observables = []

func register(observable, message: String, method: String, priority: int = 1):
	observable.register(self, message, method, priority)
	observables.append(observable)

func _get_priority():
	return 1

func unregister(observable, message: String):
	observable.unregister(self, message)

func unregister_all():
	for observable in observables:
		observable.unregister_all(self)