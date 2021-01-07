extends "res://Source/Scripts/Battle/Effect.gd"

func _save_to_json(data: Dictionary) -> void:
	if guaranteed:
		data["effect_chance"] = 0
	else:
		data["effect_chance"] = int(chance * 100)
