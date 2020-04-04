extends "res://Source/Scripts/Battle/BattleSubject.gd"

export(String) var status_name

func _heal():
	_heal_silent()

func _heal_silent():
	unregister_all()