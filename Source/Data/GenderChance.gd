extends Node

enum Gender {Male, Female, Genderless}

func _generate_gender() -> int:
	return Gender.Genderless
