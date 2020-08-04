extends Object

class Sorter:
	static func sort(a, b):
		if a.current_speed == b.current_speed:
			return Utils.trigger(0.5)
		elif a.current_speed > b.current_speed:
			return true
		else:
			return false

static func sort(pokemon_list: Array) -> void:
	pokemon_list.sort_custom(Sorter, "sort")
