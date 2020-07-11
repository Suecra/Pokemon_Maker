extends "res://Source/Scripts/Map/Movement.gd"

const STEP_DELAY = 0.1
const SPRITE_OFFSET = Global.TILE_SIZE / 2
const PREPARING_WALK = 3

var walking_time = 0.0
var stop_requested = false
var walk_requested = false
var change_direction_requested = false
var running_against_wall = false
var is_stepping = false
var velocity: Vector2
var last_direction: Vector2
var current_step_size = 0

func _walk(steps):
	if (steps > 0 || walking_time >= STEP_DELAY):
		if check_path():
			running_against_wall = false
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
	if running_against_wall:
		is_stepping = false
		return true
	return not is_stepping

func _change_direction(direction: Vector2):
	var new_direction = get_tile_based_direction(direction)
	if new_direction != last_direction:
		if is_stepping && not running_against_wall:
			change_direction_requested = true
		else:
			last_direction = new_direction
			if check_path():
				running_against_wall = false
			else:
				running_against_wall = true
			return true
	return false

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
	if is_stepping && not running_against_wall:
		body.move_and_slide(velocity)
		current_step_size += velocity.length() * delta
		if current_step_size >= Global.TILE_SIZE:
			current_step_size -= Global.TILE_SIZE
			complete_step()

func get_tile_based_direction(direction: Vector2):
	var x = int(round(direction.x))
	var y = int(round(direction.y))
	if abs(x) == abs(y):
		if last_direction.x == x:
			y = 0
		else:
			x = 0
	return Vector2(x, y)

func complete_step():
	step_taken()
	if check_path():
		running_against_wall = false
	else:
		_adjust_position()
		running_against_wall = true
	if stop_requested:
		_adjust_position()
		is_stepping = false
		character.stop()
		stop_requested = false
	if change_direction_requested:
		_adjust_position()
		is_stepping = false
		change_direction_requested = false

func _adjust_position():
	var offset = Vector2(SPRITE_OFFSET, SPRITE_OFFSET)
	var tile_pos = Utils.tile_pos(character.get_position() + offset)
	tile_pos = Vector2(round(tile_pos.x), round(tile_pos.y))
	body.global_position = Utils.pixel_pos(tile_pos) - offset

func check_path():
	var transf = body.global_transform.translated(last_direction * SPRITE_OFFSET)
	return not body.test_move(transf, last_direction)

func _after_teleport():
	_adjust_position()

func _ready():
	_adjust_position()
