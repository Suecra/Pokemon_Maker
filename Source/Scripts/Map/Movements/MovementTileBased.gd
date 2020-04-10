extends "res://Source/Scripts/Map/Movement.gd"

const STEP_DELAY = 0.1
const STEP_SIZE = 16
const SPRITE_OFFSET = 8
const PREPARING_WALK = 3

var walking_time = 0.0
var stop_requested = false
var walk_requested = false
var is_stepping = false
var velocity: Vector2
var last_direction: Vector2
var current_step_size = 0

func _walk(steps):
	if steps > 0 || walking_time >= STEP_DELAY:
		walk_requested = false
		return true
	walk_requested = true
	state = PREPARING_WALK
	return false

func _run(steps):
	return true

func _stop():
	stop_requested = true
	walk_requested = false
	return not is_stepping

func _change_direction(direction: Vector2):
	var old_direction = last_direction
	return get_tile_based_direction(direction) != old_direction

func _physics_process(delta):
	if state == STANDING || state == PREPARING_WALK:
		if walk_requested:
			walking_time += delta
		else:
			walking_time = 0
	elif state == WALKING:
		velocity = character.walking_speed * last_direction
		is_stepping = true
	elif state == RUNNING:
		velocity = character.running_speed * last_direction
		is_stepping = true
	if is_stepping:
		body.move_and_slide(velocity)
		current_step_size += velocity.length() * delta
		if current_step_size >= STEP_SIZE:
			current_step_size -= STEP_SIZE
			complete_step()

func get_tile_based_direction(direction: Vector2):
	var x = int(round(direction.x))
	var y = int(round(direction.y))
	if abs(x) == abs(y):
		if last_direction.x == x:
			y = 0
		else:
			x = 0
	last_direction = Vector2(x, y)
	return last_direction

func complete_step():
	step_taken()
	if stop_requested:
		adjust_position()
		is_stepping = false
		character.stop()
		stop_requested = false

func adjust_position():
	var tile_x = (body.global_position.x + SPRITE_OFFSET) / STEP_SIZE
	var tile_y = (body.global_position.y + SPRITE_OFFSET) / STEP_SIZE
	tile_x = round(tile_x)
	tile_y = round(tile_y)
	body.global_position.x = tile_x * STEP_SIZE - SPRITE_OFFSET
	body.global_position.y = tile_y * STEP_SIZE - SPRITE_OFFSET
	print(str(tile_x) + ", " + str(tile_y))

func _ready():
	adjust_position()
