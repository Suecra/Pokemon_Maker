extends "res://Source/Scripts/Map/Movement.gd"

var velocity: Vector2

func _walk(steps):
	return true

func _run(steps):
	return true

func _stop():
	return true

func _physics_process(delta):
	if state == STANDING:
		velocity = Vector2(0, 0)
	elif state == WALKING:
		velocity = character.walking_speed * direction
	elif state == RUNNING:
		velocity = character.running_speed * direction
	velocity = body.move_and_slide(velocity)
