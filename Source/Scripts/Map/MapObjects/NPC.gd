extends "res://Source/Scripts/Map/MapObjects/StaticMapObject.gd"

class_name NPC

enum Direction {Up, Left, Right, Down}

export(Direction) var facing = Direction.Down

onready var character = $Character

func _ready() -> void:
	match facing:
		Direction.Up: character.look(Vector2(0, -1))
		Direction.Left: character.look(Vector2(-1, 0))
		Direction.Right: character.look(Vector2(1, 0))
		Direction.Down: character.look(Vector2(0, 1))

func _get_position() -> Vector2:
	return character.get_position()

func _adjust_position() -> void:
	character.movement._adjust_position()

func _trigger() -> void:
	character.look_at(Global.player.get_position())
	._trigger()
