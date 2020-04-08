extends "res://Source/Scripts/Common/PokemonSprite.gd"

func _out_of_pokeball():
	_show()
	$AnimationPlayer.play("anim", -1, 1.1)
	yield(get_tree().create_timer(0.0), "timeout")

func _into_pokeball():
	_hide()
	$AnimationPlayer.stop()
	yield(get_tree().create_timer(0.0), "timeout")

func _faint():
	_hide()
	$AnimationPlayer.stop()
	yield(get_tree().create_timer(0.0), "timeout")

func _get_height():
	return $Sprite.texture.get_height() / $Sprite.vframes
