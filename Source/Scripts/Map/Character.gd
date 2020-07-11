extends Node2D

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const MovementTileBased = preload("res://Source/Scripts/Map/Movements/MovementTileBased.gd")
const MovementFree = preload("res://Source/Scripts/Map/Movements/MovementFree.gd")

var status setget set_status
var movement
var controller
var sprite
var walking_speed
var running_speed
var direction: Vector2

signal step_taken
signal stopped

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
	self.direction = direction.normalized()
	return movement._change_direction(self.direction)

func look(direction: Vector2):
	if change_direction(direction):
		sprite.direction = direction

func look_at(position: Vector2):
	var direction = position - get_position()
	look(direction.normalized())

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
		emit_signal("stopped")

func teleport(pos: Vector2):
	movement.body.global_position = pos
	movement._after_teleport()

func teleport_tile(x_tile: int, y_tile: int):
	teleport(Utils.pixel_pos(Vector2(x_tile, y_tile)))

func is_facing(position: Vector2):
	var delta_pos = position - get_position()
	delta_pos = delta_pos.normalized()
	var angle = direction.angle_to(delta_pos)
	if abs(angle) < PI / 4:
		return true
	return false

func get_distance(position: Vector2):
	var delta_pos = position - get_position()
	return delta_pos.length()

func _ready():
	self.status = StatusFreeMovement.new()
	
	if Global.MOVEMENT == Global.MOVEMENT_TYPE.FREE:
		movement = MovementFree.new()
	else:
		movement = MovementTileBased.new()
	movement.character = self
	movement.body = $Body
	movement.name = "Movement"
	
	sprite = $Body/Sprite
	sprite.direction = Vector2(0, 1)
	
	walking_speed = 64
	running_speed = 128
	
	add_child(movement)
