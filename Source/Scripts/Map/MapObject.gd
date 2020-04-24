extends Node2D

class_name MapObject

var spawn_radius: int
var spawned: bool
var map

func _trigger():
	pass

func _load():
	pass

func _save():
	pass

func _get_position():
	return position

func player_enter_map(map):
	self.map = map
	map.player.connect("step_taken", self, "on_player_step_taken") 
	_load()
	check_spawn()

func player_leave_map():
	_save()

func on_player_step_taken():
	pass

func check_spawn():
	var spawn = false
	var distance = map.player.global_position - position
	if distance.length() > spawn_radius && spawned:
		_despawn()
	elif distance.length() < spawn_radius && not spawned:
		_spawn()

func _spawn():
	pass

func _despawn():
	pass
