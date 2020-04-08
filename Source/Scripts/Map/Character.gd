extends Node

var status setget set_status
var movement
var controller
var sprite
var walking_speed
var running_speed

func set_status(value):
	if status != null:
		status._exit()
		remove_child($Status)
	status = value
	status.character = self
	status.name = "Status"
	add_child(status)
	status._enter()

func start_cutscene():
	if status.has_method("start_cutscene"):
		status.start_cutscene()

func end_cutscene():
	if status.has_method("end_cutscene"):
		status.end_cutscene()

func can_move():
	if status.has_method("can_move"):
		return status.can_move()
	return false

func change_direction(direction: Vector2):
	var dir = direction.normalized()
	if dir != movement.direction:
		movement.direction = dir
		return true
	return false

func look(direction: Vector2):
	change_direction(direction)

func step():
	movement.step()

func walk(steps: int = -1):
	if movement.walk(steps):
		sprite.play_animation("walk")

func run(steps: int = -1):
	if movement.run(steps):
		sprite.play_animation("run")

func stop():
	if movement.stop():
		sprite.play_animation("stop")
