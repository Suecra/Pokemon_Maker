extends "res://Source/Scripts/Common/PokemonSprite.gd"

onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite

func _out_of_pokeball() -> void:
	_show()
	animation_player.play("anim", -1, 1.1)
	yield(get_tree().create_timer(0.0), "timeout")

func _into_pokeball() -> void:
	_hide()
	animation_player.stop()
	yield(get_tree().create_timer(0.0), "timeout")

func _faint() -> void:
	_hide()
	animation_player.stop()
	yield(get_tree().create_timer(0.0), "timeout")

func _get_height() -> float:
	return sprite.texture.get_height() / sprite.vframes
