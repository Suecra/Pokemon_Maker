extends "res://Source/Scripts/Battle/BattleSubject.gd"

export(String) var status_name

func _heal():
	unregister_all()