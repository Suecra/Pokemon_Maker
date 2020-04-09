extends "res://Source/Scripts/Map/CharacterSprite.gd"

var direction_string = ""
var animation_name = ""

func _set_direction(value):
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
		$AnimationPlayer.play(animation_name + "_" + direction_string)

func _has_animation(name):
	return $AnimationPlayer.has_animation(name + "_" + direction_string)

func _play_animation(name):
	animation_name = name
	$AnimationPlayer.play(animation_name + "_" + direction_string)
