extends KinematicBody2D

var direction = Vector2(0, 0)

func _ready():
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_down"):
		get_node("AnimationPlayer").play("walk_down")
		direction.y = 1
	if Input.is_action_just_pressed("ui_up"):
		get_node("AnimationPlayer").play("walk_up");
		direction.y = -1
	if Input.is_action_just_pressed("ui_left"):
		get_node("AnimationPlayer").play("walk_left");
		direction.x = -1
	if Input.is_action_just_pressed("ui_right"):
		get_node("AnimationPlayer").play("walk_right");
		direction.x = 1
	
	if Input.is_action_just_released("ui_down"):
		direction.y = 0
	if Input.is_action_just_released("ui_up"):
		direction.y = 0
	if Input.is_action_just_released("ui_left"):
		direction.x = 0
	if Input.is_action_just_released("ui_right"):
		direction.x = 0
	move_and_slide(direction.normalized() * 100);