extends "res://Source/Scripts/Map/EventAction.gd"

class_name EventActionTurn

enum Direction {Up, Left, Right, Down}

export(Direction) var direction = Direction.Up
var character

func _execute():
	character = event.caller.character
	match direction:
		Direction.Up: character.look(Vector2(0, -1))
		Direction.Left: character.look(Vector2(-1, 0))
		Direction.Right: character.look(Vector2(1, 0))
		Direction.Down: character.look(Vector2(0, 1))
	return false

func _init(direction):
	self.direction = direction
