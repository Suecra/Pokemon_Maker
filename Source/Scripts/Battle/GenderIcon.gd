extends Node2D

enum Gender {Male, Female, Genderless}

export(Gender) var gender setget set_gender

func set_gender(value) -> void:
	gender = value
	match gender:
		Gender.Male:
			$male.visible = true
			$female.visible = false
		Gender.Female:
			$male.visible = false
			$female.visible = true
		Gender.Genderless:
			$male.visible = false
			$female.visible = false
