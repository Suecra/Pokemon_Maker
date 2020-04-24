extends Node2D

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

func enter(player, x: int, y: int):
	self.player = player
	add_child(player)
	player.position.x = x
	player.position.y = y
	init_map_objects(self)

func enter_tile(player, x_tile: int, y_tile: int):
	enter(player, x_tile * Global.TILE_SIZE, y_tile * Global.TILE_SIZE)

func leave():
	deinit_map_objects(self)

func _ready():
	pass
