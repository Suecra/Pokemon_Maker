extends "res://Source/Scripts/Battle/BattleSubject.gd"

export(String) var status_name

func _heal() -> void:
	_heal_silent()

func _heal_silent() -> void:
	unregister_all()
