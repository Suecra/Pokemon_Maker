extends Node

var observables = []

func register(observable, message: String, method: String, priority: int = 1) -> void:
	observable.register(self, message, method, priority)
	observables.append(observable)

func _get_priority() -> int:
	return 1

func unregister(observable, message: String) -> void:
	observable.unregister(self, message)

func unregister_all() -> void:
	for observable in observables:
		observable.unregister_all(self)
