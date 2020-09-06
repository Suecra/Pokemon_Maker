extends Node

const STANDING = 0
const WALKING = 1
const RUNNING = 2

var state = 0
var character: Node
var body: KinematicBody2D
var direction: Vector2
var remaining_steps = 0

signal step_taken

func step_taken() -> void:
	if remaining_steps > 0:
		remaining_steps -= 1
	if remaining_steps == 0:
		character.stop()
	character.emit_signal("step_taken")

func step() -> void:
	if state == WALKING:
		character.walk(1)
	elif state == RUNNING:
		character.run(1)

func walk(steps: int) -> bool:
	if state != WALKING:
		if _walk(steps):
			state = WALKING
			remaining_steps = steps
			return true
	return false

func run(steps: int) -> bool:
	if state != RUNNING:
		if _run(steps):
			state = RUNNING
			remaining_steps = steps
			return true
	return false

func stop() -> bool:
	if state != STANDING:
		if _stop():
			state = STANDING
			return true
	return false

func _walk(steps: int) -> bool:
	return false

func _run(steps: int) -> bool:
	return false

func _stop() -> bool:
	return false

func _change_direction(direction: Vector2) -> bool:
	return false

func _after_teleport() -> void:
	pass

func _adjust_position() -> void:
	pass
