extends "res://Source/Scripts/Battle/PrimaryStatus.gd"

func _can_move(args):
	args.can_move = false

func _ready():
	status_name = "Faint"
	register(pokemon, "CAN_MOVE", "_can_move")