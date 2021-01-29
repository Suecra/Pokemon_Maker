extends "res://Source/Scripts/Battle/StatusBarStyleBase.gd"

export(Color, RGB) var high_hp_color
export(Color, RGB) var medium_hp_color
export(Color, RGB) var low_hp_color

export(Color, RGB) var burn_color
export(Color, RGB) var para_color
export(Color, RGB) var sleep_color
export(Color, RGB) var poison_color
export(Color, RGB) var freeze_color

export(float) var hp_percent = 1.0 setget set_hp_percent

export(int) var hp_x_offset
export(int) var hp_y_offset
export(int) var hp_width
export(int) var hp_height

export(int) var status_x_offset
export(int) var status_y_offset
export(int) var status_size

onready var lbl_level := $Level
onready var lbl_name := $Name
onready var anim_player := $AnimationPlayer
var hp_animation

func set_hp_percent(value: float) -> void:
	hp_percent = value
	update()

func _update_hp() -> void:
	self.hp_percent = float(hp) / float(max_hp)

func _update_max_hp() -> void:
	self.hp_percent = float(hp) / float(max_hp)

func _animate_hp(old_hp: int) -> void:
	hp_animation.track_set_key_value(0, 0, float(old_hp) / float(max_hp))
	hp_animation.track_set_key_value(0, 1, float(hp) / float(max_hp))
	anim_player.play("hp")

func _update_level() -> void:
	lbl_level.text = str(level)

func _update_pokemon_name() -> void:
	lbl_name.text = pokemon_name

func _update_gender() -> void:
	pass

func _update_status() -> void:
	update()

func _draw() -> void:
	var points = []
	var origin = $Sprite/Overlay.position
	var length
	if hp == 0 || hp == max_hp:
		length = hp_width * hp_percent
	else:
		length = hp_width * max(min(hp_percent, 0.975), 0.025)
	points.append(Vector2(origin.x + hp_x_offset, origin.y + hp_y_offset))
	points.append(Vector2(origin.x + hp_x_offset - hp_height, origin.y + hp_y_offset + hp_height))
	points.append(Vector2(origin.x + hp_x_offset + length - hp_height, origin.y + hp_y_offset + hp_height))
	points.append(Vector2(origin.x + hp_x_offset + length, origin.y + hp_y_offset))
	var color
	var alpha
	if hp_percent >= 0.5:
		alpha = (hp_percent - 0.5) / 0.5
		color = medium_hp_color.blend(Color(high_hp_color.r, high_hp_color.g, high_hp_color.b, alpha))
	else:
		alpha = hp_percent / 0.5
		color = low_hp_color.blend(Color(medium_hp_color.r, medium_hp_color.g, medium_hp_color.b, alpha))
	draw_colored_polygon(points, color)
	
	if status != "":
		points.clear()
		points.append(Vector2(origin.x + status_x_offset, origin.y + status_y_offset))
		points.append(Vector2(origin.x + status_x_offset, origin.y + status_y_offset + status_size))
		points.append(Vector2(origin.x + status_x_offset + status_size, origin.y + status_y_offset))
		color = 0
		match status.to_lower():
			"burn": color = burn_color
			"paralysis": color = para_color
			"sleep": color = sleep_color
			"poison": color = poison_color
			"freeze": color = freeze_color
		draw_colored_polygon(points, color)

func _ready():
	hp_animation = anim_player.get_animation("hp")
	anim_player.connect("animation_finished", self, "hp_anim_finished")
	hp = 100
	max_hp = 100

func hp_anim_finished(anim_name: String) -> void:
	finish_animation()
