extends Node2D

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const MovementTileBased = preload("res://Source/Scripts/Map/Movements/MovementTileBased.gd")
const MovementFree = preload("res://Source/Scripts/Map/Movements/MovementFree.gd")

var status: Node setget set_status
var movement: Node
var controller: Node
var walking_speed: int
var running_speed: int
var direction: Vector2

onready var body := $Body
onready var sprite := $Body/Sprite

signal step_taken
signal stopped

func get_position() -> Vector2:
	return movement.body.global_position

func set_status(value: Node) -> void:
	if status != null:
		status._exit()
		remove_child(status)
	status = value
	status.character = self
	status.name = "Status"
	add_child(status)
	status._enter()

func start_cutscene() -> void:
	if status.has_method("start_cutscene"):
		status.start_cutscene()

func end_cutscene() -> void:
	if status.has_method("end_cutscene"):
		status.end_cutscene()

func can_move() -> bool:
	if status.has_method("can_move"):
		return status.can_move()
	return false

func change_direction(direction: Vector2) -> bool:
	if movement._change_direction(direction.normalized()):
		self.direction = movement.direction
		return true
	return false

func look(direction: Vector2) -> void:
	if change_direction(direction):
		sprite.direction = direction

func look_at(position: Vector2) -> void:
	var direction = position - get_position()
	look(direction.normalized())

func step() -> void:
	movement.step()

func walk(steps: int = -1) -> void:
	if movement.walk(steps):
		sprite.play_animation("walk")

func run(steps: int = -1) -> void:
	if movement.run(steps):
		sprite.play_animation("run")

func stop() -> void:
	if movement.stop():
		sprite.play_animation("stop")
		emit_signal("stopped")

func teleport(map: Node, position: Vector2) -> void:
	var parent = get_parent()
	if parent != map:
		parent.remove_child(self)
		map.add_child(self)
	movement.body.global_position = position
	movement._after_teleport()

func teleport_tile(map: Node, x_tile: int, y_tile: int) -> void:
	teleport(map, Utils.pixel_pos(Vector2(x_tile, y_tile)))

func is_facing(position: Vector2) -> bool:
	var delta_pos = position - get_position()
	delta_pos = delta_pos.normalized()
	var angle = direction.angle_to(delta_pos)
	if abs(angle) < PI / 4:
		return true
	return false

func get_distance(position: Vector2) -> float:
	var delta_pos = position - get_position()
	return delta_pos.length()

func _ready() -> void:
	self.status = StatusFreeMovement.new()
	
	if Consts.MOVEMENT == Consts.MOVEMENT_TYPE.FREE:
		movement = MovementFree.new()
	else:
		movement = MovementTileBased.new()
	movement.character = self
	movement.body = body
	movement.name = "Movement"
	
	sprite.direction = Vector2(0, 1)
	
	walking_speed = 64
	running_speed = 128
	
	add_child(movement)
