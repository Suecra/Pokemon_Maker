extends "res://Source/Scripts/Simulator/ListEdit.gd"

const MoveList = preload("res://Source/Scripts/Collections/MoveList.gd")

func _get_items(filter: String):
	return MoveList.get_move_filter_dict(filter)

func _add_dictionary_item(item, key):
	$List.add_item(item["name"])