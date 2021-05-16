extends "res://Source/Scripts/Map/Movement.gd"

const SPRITE_OFFSET = Consts.TILE_SIZE / 2

var last_direction: Vector2
var new_direction: Vector2
var total_movement = 0.0
var move_speed = 0.0
var stopping = false
var turning = false
var turned = false
var blocked = false

func _walk(steps: int) -> bool:
	blocked = blocked || (state == STANDING && not check_path())
	move_speed = character.walking_speed
	stopping = false
	return true

func _run(steps: int) -> bool:
	blocked = blocked || (state == STANDING && not check_path())
	move_speed = character.running_speed
	stopping = false
	return true

func _stop() -> bool:
	if total_movement > 0:
		stopping = true
		return false
	_adjust_position()
	return true

func _change_direction(direction: Vector2) -> bool:
	new_direction = get_tile_based_direction(direction)
	if new_direction != last_direction && (state == STANDING || blocked):
		last_direction = new_direction
		self.direction = direction
		blocked = false
		turned = true
		return true
	if turning:
		turning = false
		turned = true
		return true
	return false

func _after_teleport() -> void:
	_adjust_position()

func _adjust_position() -> void:
	var offset = Vector2(SPRITE_OFFSET, SPRITE_OFFSET)
	var tile_pos = Utils.tile_pos(character.get_position() + offset)
	tile_pos = Vector2(round(tile_pos.x), round(tile_pos.y))
	body.global_position = Utils.pixel_pos(tile_pos) - offset

func _physics_process(delta):
	match state:
		WALKING, RUNNING:
			if turned:
				blocked = not check_path()
				turned = false
			if check_path() || total_movement > 0:
				var movement = move_speed * delta
				movement = min(movement, Consts.TILE_SIZE - total_movement)
				total_movement += movement
				body.move_and_collide(movement * last_direction)
				if total_movement == Consts.TILE_SIZE:
					total_movement = 0
					step_taken()
					blocked = not check_path()
					if stopping:
						character.stop()
					if new_direction != last_direction:
						last_direction = new_direction
						turning = true

func get_tile_based_direction(direction: Vector2) -> Vector2:
	var x = int(round(direction.x))
	var y = int(round(direction.y))
	if abs(x) == abs(y):
		if last_direction.x == x:
			y = 0
		else:
			x = 0
	return Vector2(x, y)

func check_path() -> bool:
	var transf = body.global_transform.translated(last_direction * SPRITE_OFFSET)
	return not body.test_move(transf, last_direction)
