extends Node2D

const LOW_HP_PERCENT = 50
const VERY_LOW_HP_PERCENT = 25

export(Color) var high_hp_color
export(Color) var low_hp_color
export(Color) var very_low_hp_color
export(Color) var gray_hp_color
export(Rect2) var hp_bar_rect

var player_hp_bar
var enemy_hp_bar
var percent
var gray_percent
var color
var max_hp setget _set_max_hp;
export(int) var hp setget _set_hp;
var gray_hp setget _set_gray_hp;

func _play_damage_animation(hp):
	var animation = $AnimationPlayer.get_animation("damage")
	animation.track_set_key_value(0, 0, self.hp)
	animation.track_set_key_value(0, 1, hp)
	$AnimationPlayer.play("damage")
	yield($AnimationPlayer, "animation_finished")

func _set_max_hp(value):
	max_hp = value
	set_percent((hp / float(max_hp)) * 100)
	
func _set_hp(value):
	hp = value
	set_percent((hp / float(max_hp)) * 100)

func _set_gray_hp(value):
	gray_hp = value
	set_gray_percent((gray_hp / float(max_hp)) * 100)

func set_percent(value):
	percent = max(value, 0)
	percent = min(percent, 100)
	if percent != 0 && percent < 1:
		percent = 1
	if percent <= VERY_LOW_HP_PERCENT:
		draw(very_low_hp_color)
	elif percent <= LOW_HP_PERCENT:
		draw(low_hp_color)
	else:
		draw(high_hp_color)

func set_gray_percent(value):
	gray_percent = max(value, 0)
	gray_percent = min(gray_percent, 100)

func draw(color: Color):
	self.color = color
	update()

func _draw():
	var rect = get_percent_rect(gray_percent)
	draw_rect(rect, gray_hp_color)
	rect = get_percent_rect(percent)
	draw_rect(rect, color)

func get_percent_rect(percent):
	return hp_bar_rect.grow_margin(MARGIN_RIGHT, -hp_bar_rect.size.x * (float(100 - percent) / 100))

func _ready():
	max_hp = 0
	hp = 0
	gray_hp = 0
	gray_percent = 0