extends "res://Source/Scripts/Map/CharacterSprite.gd"

const BODY_HEIGHT = 32
const WALK_ANIM_SPEED = 0.1
const RUN_ANIM_SPEED = 0.05

export(Texture) var texture_walk
export(Texture) var texture_run
export(int) var frames = 4
export(bool) var walk_include_first_frame = false

var animation_player
var direction_string := ""
var animation_name := "stop"
var walk_sprite_width
var run_sprite_width
var walk_sprite_height
var run_sprite_height
var walk_head_height
var run_head_height

func _set_direction(value: Vector2) -> void:
	._set_direction(value)
	var x = int(round(value.x))
	var y = int(round(value.y))
	var new_direction
	if x == -1:
		new_direction = "left"
	if x == 1:
		new_direction = "right"
	if y == -1:
		new_direction = "up"
	if y == 1:
		new_direction = "down"
	if new_direction != direction_string:
		direction_string = new_direction
		animation_player.play(animation_name + "_" + direction_string)

func _has_animation(name: String) -> bool:
	return animation_player.has_animation(name + "_" + direction_string)

func _play_animation(name: String) -> void:
	animation_name = name
	animation_player.play(animation_name + "_" + direction_string)

func _stop_animation() -> void:
	animation_player.stop()

func get_walk_head_rect(hframe: int, vframe: int) -> Rect2:
	return Rect2(walk_sprite_width * hframe, walk_sprite_height * vframe, walk_sprite_width, walk_head_height)

func get_run_head_rect(hframe: int, vframe: int) -> Rect2:
	return Rect2(run_sprite_width * hframe, run_sprite_height * vframe, run_sprite_width, run_head_height)

func prepare_animations() -> void:
	var walk_head_rect = Rect2(0, 0, walk_sprite_width, walk_head_height)
	var run_head_rect = Rect2(0, 0, run_sprite_width, run_head_height)
	
	var anim
	var anims = ["stop_down", "stop_left", "stop_right", "stop_up"]
	for i in range(4):
		anim = animation_player.get_animation(anims[i])
		anim.track_set_key_value(0, 0, i * frames)
		anim.track_set_key_value(3, 0, get_walk_head_rect(0, i))
	
	anims = ["walk_down", "walk_left", "walk_right", "walk_up"]
	for i in range(4):
		anim = animation_player.get_animation(anims[i])
		anim.track_insert_key(0, 0, i * frames + (frames - 1))
		anim.track_insert_key(3, 0, get_walk_head_rect(frames - 1, i))
		if walk_include_first_frame:
			anim.length = WALK_ANIM_SPEED * frames
			for k in range(frames - 1):
				anim.track_insert_key(0, WALK_ANIM_SPEED * (k + 1), i * frames + k)
				anim.track_insert_key(3, WALK_ANIM_SPEED * (k + 1), get_walk_head_rect(k, i))
		else:
			anim.length = WALK_ANIM_SPEED * (frames - 1)
			for k in range(frames - 2):
				anim.track_insert_key(0, WALK_ANIM_SPEED * (k + 1), i * frames + k + 1)
				anim.track_insert_key(3, WALK_ANIM_SPEED * (k + 1), get_walk_head_rect(k + 1, i))
	
	anims = ["run_down", "run_left", "run_right", "run_up"]
	for i in range(4):
		anim = animation_player.get_animation(anims[i])
		anim.length = RUN_ANIM_SPEED * frames
		anim.track_insert_key(0, 0, i * frames + (frames - 1))
		anim.track_insert_key(3, 0, get_run_head_rect(frames - 1, i))
		for k in range(frames - 1):
			anim.track_insert_key(0, RUN_ANIM_SPEED * (k + 1), i * frames + k)
			anim.track_insert_key(3, RUN_ANIM_SPEED * (k + 1), get_run_head_rect(k, i))

func _ready() -> void:
	animation_player = $AnimationPlayer.duplicate()
	animation_player.name = "ActualAnimationPlayer"
	add_child(animation_player)
	animation_player.owner = self
	remove_child($AnimationPlayer)
	
	$SpriteWalk.texture = texture_walk
	$SpriteWalk.hframes = frames
	$SpriteWalk/Head.texture = texture_walk
	$SpriteRun.texture = texture_run
	$SpriteRun.hframes = frames
	$SpriteRun/Head.texture = texture_run
	walk_sprite_width = texture_walk.get_width() / frames
	run_sprite_width = texture_run.get_width() / frames
	walk_sprite_height = texture_walk.get_height() / 4
	run_sprite_height = texture_run.get_height() / 4
	walk_head_height = walk_sprite_height - BODY_HEIGHT
	run_head_height = run_sprite_height - BODY_HEIGHT
	$SpriteWalk/Head.offset.x = -walk_sprite_width / 2
	$SpriteWalk/Head.offset.y = -walk_sprite_height / 2
	$SpriteRun/Head.offset.x = -run_sprite_width / 2
	$SpriteRun/Head.offset.y = -run_sprite_height / 2
	prepare_animations()
