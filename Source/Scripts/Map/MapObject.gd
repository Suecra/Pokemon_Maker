extends Node2D

class_name MapObject

enum TriggerType {Ground, ActionPress}

export(TriggerType) var trigger_type
export(int) var trigger_range

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
	check_spawn()

func check_spawn():
	var distance = map.player.get_position() - _get_position()
	if distance.length() > spawn_radius && spawned:
		_despawn()
	elif distance.length() < spawn_radius && not spawned:
		_spawn()

func _spawn():
	spawned = true
	set_physics_process(true)

func _despawn():
	spawned = false
	set_physics_process(false)

func _ready():
	_despawn()
