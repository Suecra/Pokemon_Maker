extends Node2D

const LOW_HP_PERCENT = 50
const VERY_LOW_HP_PERCENT = 25

export(Color) var high_hp_color
export(Color) var low_hp_color
export(Color) var very_low_hp_color
export(Rect2) var hp_bar_rect

var player_hp_bar
var enemy_hp_bar
var percent
var color
var max_hp setget _set_max_hp;
var hp setget _set_hp;

func _set_max_hp(value):
	max_hp = value
	set_percent((hp / float(max_hp)) * 100)
	
func _set_hp(value):
	hp = value
	print("set hp " + str(value))
	set_percent((hp / float(max_hp)) * 100)

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

func draw(color: Color):
	self.color = color
	update()

func _draw():
	var rect = hp_bar_rect.grow_margin(MARGIN_RIGHT, -hp_bar_rect.size.x * (float(100 - percent) / 100))
	draw_rect(rect, color)

func _ready():
	max_hp = 0
	hp = 0