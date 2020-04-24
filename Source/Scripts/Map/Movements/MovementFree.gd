extends "res://Source/Scripts/Map/Movement.gd"

var current_step_size = 0
var velocity: Vector2

func _walk(steps):
	return true

func _run(steps):
	return true

func _stop():
	return true

func _change_direction(direction: Vector2):
	if direction != self.direction:
		self.direction = direction
		return true
	return false

func _physics_process(delta):
	if state == STANDING:
		velocity = Vector2(0, 0)
		current_step_size = 0
	elif state == WALKING:
		velocity = character.walking_speed * direction
	elif state == RUNNING:
		velocity = character.running_speed * direction
	current_step_size += velocity.length() * delta
	if current_step_size >= Global.TILE_SIZE:
		current_step_size -= Global.TILE_SIZE
		step_taken()
	velocity = body.move_and_slide(velocity)
