extends "PMDataObject.gd"

enum Gender {Male, Female, Genderless}

func _load_from_json(data: Dictionary) -> void:
	print("Loading GenderChance from json is not supported!")

func _save_to_json(data: Dictionary) -> void:
	data["gender_rate"] = _get_gender_rate()
	
func _get_gender_rate() -> int:
	return -1
	
func _generate_gender() -> int:
	return Gender.Genderless
