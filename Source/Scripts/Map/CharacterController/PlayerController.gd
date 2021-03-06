extends "res://Source/Scripts/Map/CharacterController.gd"

const WALK_DELAY = 0.1

var press_time_horz = 0.0
var press_time_vert = 0.0

func _physics_process(delta: float) -> void:
	var x = 0
	var y = 0
	if Input.is_action_pressed("move_left"):
		x = -1
		press_time_horz += delta
	elif Input.is_action_pressed("move_right"):
		x = 1
		press_time_horz += delta
	else:
		x = 0
		press_time_horz = 0.0
	if Input.is_action_pressed("move_up"):
		y = -1
		press_time_vert += delta
	elif Input.is_action_pressed("move_down"):
		y = 1
		press_time_vert += delta
	else:
		y = 0
		press_time_vert = 0.0
	if x == 0 && y == 0:
		character.stop()
	else:
		character.look(Vector2(x, y))
		if Input.is_action_pressed("run|back"):
			character.run()
		elif press_time_horz >= WALK_DELAY || press_time_vert >= WALK_DELAY:
			character.walk()
	if Input.is_action_just_pressed("select|action"):
		character.action_pressed()
	if Input.is_key_pressed(KEY_CONTROL):
		character.movement.body.get_node("Collision").disabled = true
		character.movement.debug_mode = true
	else:
		character.movement.body.get_node("Collision").disabled = false
		character.movement.debug_mode = false
