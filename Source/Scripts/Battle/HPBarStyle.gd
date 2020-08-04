extends Node2D

const LOW_HP_PERCENT = 50
const VERY_LOW_HP_PERCENT = 25

export(Color) var high_hp_color
export(Color) var low_hp_color
export(Color) var very_low_hp_color
export(Color) var gray_hp_color
export(Rect2) var hp_bar_rect

var player_hp_bar: Node
var enemy_hp_bar: Node
var percent: float
var gray_percent: float
var color: Color
var max_hp: int setget _set_max_hp
export(int) var hp setget _set_hp
var gray_hp: int setget _set_gray_hp

onready var animation_player := $AnimationPlayer

func _play_damage_animation(hp: int) -> void:
	var animation = animation_player.get_animation("damage")
	animation.track_set_key_value(0, 0, self.hp)
	animation.track_set_key_value(0, 1, hp)
	animation_player.play("damage")
	yield(animation_player, "animation_finished")

func _set_max_hp(value: int) -> void:
	max_hp = value
	set_percent((hp / float(max_hp)) * 100)
	
func _set_hp(value: int) -> void:
	hp = value
	set_percent((hp / float(max_hp)) * 100)

func _set_gray_hp(value: int) -> void:
	gray_hp = value
	set_gray_percent((gray_hp / float(max_hp)) * 100)

func set_percent(value: float) -> void:
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

func set_gray_percent(value: float) -> void:
	gray_percent = max(value, 0)
	gray_percent = min(gray_percent, 100)

func draw(color: Color) -> void:
	self.color = color
	update()

func _draw() -> void:
	var rect = get_percent_rect(gray_percent)
	draw_rect(rect, gray_hp_color)
	rect = get_percent_rect(percent)
	draw_rect(rect, color)

func get_percent_rect(percent: float) -> Rect2:
	return hp_bar_rect.grow_margin(MARGIN_RIGHT, -hp_bar_rect.size.x * (float(100 - percent) / 100))

func _ready() -> void:
	max_hp = 0
	hp = 0
	gray_hp = 0
	gray_percent = 0
