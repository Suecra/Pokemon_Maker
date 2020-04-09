extends "res://Source/Scripts/Map/CharacterController.gd"

func _physics_process(delta):
	var x = 0
	var y = 0
	if Input.is_action_pressed("move_left"):
		x = -1
	elif Input.is_action_pressed("move_right"):
		x = 1
	else:
		x = 0
	if Input.is_action_pressed("move_up"):
		y = -1
	elif Input.is_action_pressed("move_down"):
		y = 1
	else:
		y = 0
	if x == 0 && y == 0:
		character.stop()
	else:
		character.look(Vector2(x, y))
		character.walk()
