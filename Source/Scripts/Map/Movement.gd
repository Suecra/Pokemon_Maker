extends Node

const STANDING = 0
const WALKING = 1
const RUNNING = 2

var state = 0
var character
var body: KinematicBody2D
var direction: Vector2
var remaining_steps = 0

signal step_taken

func step_taken():
	if remaining_steps > 0:
		remaining_steps -= 1
	if remaining_steps == 0:
		character.stop()
	character.emit_signal("step_taken")

func step():
	if state == WALKING:
		character.walk(1)
	elif state == RUNNING:
		character.run(1)

func walk(steps: int):
	if state != WALKING:
		if _walk(steps):
			state = WALKING
			remaining_steps = steps
			return true
	return false

func run(steps: int):
	if state != RUNNING:
		if _run(steps):
			state = RUNNING
			remaining_steps = steps
			return true
	return false

func stop():
	if state != STANDING:
		if _stop():
			state = STANDING
			return true
	return false

func _walk(steps: int):
	pass

func _run(steps: int):
	pass

func _stop():
	pass

func _change_direction(direction: Vector2):
	pass

func _after_teleport():
	pass

func _adjust_position():
	pass
