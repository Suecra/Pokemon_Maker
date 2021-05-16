extends Node2D

class_name MapObject

const SPRITE_OFFSET = Consts.TILE_SIZE / 2

enum TriggerType {Ground, ActionPress}

export(TriggerType) var trigger_type
export(int) var trigger_range

var spawn_radius: int
var spawned: bool

func _trigger() -> void:
	pass

func _load() -> void:
	pass

func _save() -> void:
	pass

func _get_position() -> Vector2:
	return position

func _adjust_position() -> void:
	if Consts.MOVEMENT == Consts.MOVEMENT_TYPE.TILE:
		var offset = Vector2(SPRITE_OFFSET, SPRITE_OFFSET)
		var tile_pos = Utils.tile_pos(position + offset)
		tile_pos = Vector2(round(tile_pos.x), round(tile_pos.y))
		position = Utils.pixel_pos(tile_pos) - offset

func player_enter_map() -> void:
	Global.player.connect("step_taken", self, "on_player_step_taken") 
	_load()
	check_spawn()

func player_leave_map() -> void:
	_save()

func on_player_step_taken() -> void:
	check_spawn()

func check_spawn() -> void:
	var distance = Global.player.get_position() - _get_position()
	if distance.length() > spawn_radius && spawned:
		_despawn()
	elif distance.length() < spawn_radius && not spawned:
		_spawn()

func _spawn() -> void:
	spawned = true
	_adjust_position()
	Global.player.connect("action", self, "player_action")

func _despawn() -> void:
	spawned = false
	Global.player.disconnect("action", self, "player_action")

func player_action() -> void:
	if trigger_type == TriggerType.ActionPress:
		if Global.player.is_facing(_get_position()):
			if Global.player.get_distance(_get_position()) <= trigger_range:
				Global.player.request_trigger(self)

func _ready() -> void:
	spawn_radius = Consts.MAP_OBJECT_SPAWN_RADIUS
	spawned = false
