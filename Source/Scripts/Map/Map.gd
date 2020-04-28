extends Node2D

const Utils = preload("res://Source/Scripts/Utils.gd")

var player

func init_map_objects(node):
	if node is MapObject:
		node.player_enter_map(self)
	else:
		for child in node.get_children():
			init_map_objects(child)

func deinit_map_objects(node):
	if node is MapObject:
		node.player_leave_map(self)
	else:
		for child in node.get_children():
			deinit_map_objects(child)

func enter(player, position: Vector2):
	self.player = player
	add_child(player)
	player.teleport(position)
	init_map_objects(self)

func enter_tile(player, x_tile: int, y_tile: int):
	enter(player, Utils.pixel_pos(Vector2(x_tile, y_tile)))

func leave():
	deinit_map_objects(self)

func _ready():
	get_tree().create_timer(1).connect("timeout", self, "timer_timeout")

func timer_timeout():
	enter_tile($Player, 0, 0)
