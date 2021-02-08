extends "res://Source/Scripts/Common/Textboxes/TextboxStyleBase.gd"

export(Texture) var texture
export(Rect2) var inner_rect
export(bool) var fit_horizontal setget set_fit_horizontal
export(bool) var fit_vertical setget set_fit_vertical

var top_left: ImageTexture
var top: ImageTexture
var top_right: ImageTexture
var left: ImageTexture
var center: ImageTexture
var right: ImageTexture
var bottom_left: ImageTexture
var bottom: ImageTexture
var bottom_right: ImageTexture
var is_init = false

func set_fit_horizontal(value: bool) -> void:
	if fit_horizontal != value:
		fit_horizontal = value
		_update_rect()

func set_fit_vertical(value: bool) -> void:
	if fit_vertical != value:
		fit_vertical = value
		_update_rect()

func _update_rect() -> void:
	if is_init:
		if fit_horizontal:
			var min_width = left.get_width() + right.get_width()
			var tile_width = center.get_width()
			var delta_width = rect.size.x - min_width
			var horz_tile_count = float(delta_width) / float(tile_width)
			horz_tile_count = round(horz_tile_count)
			rect.size.x = tile_width * horz_tile_count + min_width
		if fit_vertical:
			var min_height = left.get_height() + right.get_height()
			var tile_height = center.get_height()
			var delta_height = rect.size.y - min_height
			var vert_tile_count = float(delta_height) / float(tile_height)
			vert_tile_count = round(vert_tile_count)
			rect.size.y = tile_height * vert_tile_count + min_height
		update()

func _draw() -> void:
	draw_texture(top_left, rect.position)
	draw_texture(top_right, Vector2(rect.end.x - top_right.get_width(), rect.position.y))
	draw_texture(bottom_left, Vector2(rect.position.x, rect.end.y - bottom_left.get_height()))
	draw_texture(bottom_right, Vector2(rect.end.x - top_right.get_width(), rect.end.y - bottom_left.get_height()))
	
	draw_texture_rect(top, Rect2(rect.position.x + top_left.get_width(), rect.position.y, rect.size.x - top_right.get_width() - top_left.get_width(), top_left.get_height()), true)
	draw_texture_rect(left, Rect2(rect.position.x, rect.position.y + top_left.get_height(), top_right.get_width(), rect.size.y - top_left.get_height() - bottom_left.get_height()), true)
	draw_texture_rect(right, Rect2(rect.end.x - top_left.get_width(), rect.position.y + top_left.get_height(), top_right.get_width(), rect.size.y - top_right.get_height() - bottom_right.get_height()), true)
	draw_texture_rect(bottom, Rect2(rect.position.x + bottom_left.get_width(), rect.end.y - bottom_left.get_height(), rect.size.x - bottom_right.get_width() - bottom_left.get_width(), bottom_left.get_height()), true)
	draw_texture_rect(center, Rect2(rect.position.x + bottom_left.get_width(), rect.position.y + top_left.get_height(), rect.size.x - bottom_right.get_width() - bottom_left.get_width(), rect.size.y - top_left.get_height() - bottom_left.get_height()), true)

func _ready() -> void:
	var img: Image = texture.get_data()
	top_left = ImageTexture.new()
	top_left.create_from_image(img.get_rect(Rect2(Vector2(0, 0), Vector2(inner_rect.position))), 0)
	
	top = ImageTexture.new()
	top.create_from_image(img.get_rect(Rect2(inner_rect.position.x, 0, inner_rect.size.x, inner_rect.position.y)), 0)
	
	top_right = ImageTexture.new()
	top_right.create_from_image(img.get_rect(Rect2(inner_rect.end.x, 0, img.get_width() - inner_rect.end.x, inner_rect.position.y)), 0)
	
	left = ImageTexture.new()
	left.create_from_image(img.get_rect(Rect2(0, inner_rect.position.y, inner_rect.position.x, inner_rect.size.y)), 0)
	
	center = ImageTexture.new()
	center.create_from_image(img.get_rect(Rect2(inner_rect)))
	
	right = ImageTexture.new()
	right.create_from_image(img.get_rect(Rect2(inner_rect.end.x, inner_rect.position.y, img.get_width() - inner_rect.end.x, inner_rect.size.y)), 0)
	
	bottom_left = ImageTexture.new()
	bottom_left.create_from_image(img.get_rect(Rect2(0, inner_rect.end.y, inner_rect.position.x, img.get_height() - inner_rect.end.y)), 0)
	
	bottom = ImageTexture.new()
	bottom.create_from_image(img.get_rect(Rect2(inner_rect.position.x, inner_rect.end.y, inner_rect.size.x, img.get_height() - inner_rect.end.y)), 0)
	
	bottom_right = ImageTexture.new()
	bottom_right.create_from_image(img.get_rect(Rect2(inner_rect.end, img.get_size() - inner_rect.end)), 0)
	
	is_init = true
