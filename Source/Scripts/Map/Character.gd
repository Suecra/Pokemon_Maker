extends Node2D

const Utils = preload("res://Source/Scripts/Utils.gd")

var status setget set_status
var movement
var controller
var sprite
var walking_speed
var running_speed

signal step_taken

func get_position():
	return movement.body.global_position

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
	return movement._change_direction(direction.normalized())

func look(direction: Vector2):
	if change_direction(direction):
		sprite.direction = direction

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

func teleport(pos: Vector2):
	position = pos
	movement._after_teleport()

func teleport_tile(x_tile: int, y_tile: int):
	teleport(Utils.pixel_pos(Vector2(x_tile, y_tile)))
