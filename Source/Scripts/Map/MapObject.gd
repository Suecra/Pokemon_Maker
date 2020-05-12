extends Node2D

class_name MapObject

const Utils = preload("res://Source/Scripts/Utils.gd")
const SPRITE_OFFSET = Global.TILE_SIZE / 2

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

func adjust_position():
	if Global.MOVEMENT == Global.MOVEMENT_TYPE.TILE:
		var offset = Vector2(SPRITE_OFFSET, SPRITE_OFFSET)
		var tile_pos = Utils.tile_pos(_get_position() + offset)
		tile_pos = Vector2(round(tile_pos.x), round(tile_pos.y))
		position = Utils.pixel_pos(tile_pos) - offset

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
	adjust_position()
	map.player.connect("action", self, "player_action")

func _despawn():
	spawned = false
	map.player.disconnect("action", self, "player_action")

func player_action():
	if trigger_type == TriggerType.ActionPress:
		if map.player.is_facing(_get_position()):
			if map.player.get_distance(_get_position()) <= trigger_range:
				map.player.request_trigger(self)

func _ready():
	spawned = false
