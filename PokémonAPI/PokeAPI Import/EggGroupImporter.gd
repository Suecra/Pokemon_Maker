extends "Importer.gd"

const EggGroup = preload("res://Source/EggGroup.gd")

func _create_item():
	return EggGroup.new()

func _import_item(item):
	yield(get_tree().create_timer(0), "timeout")