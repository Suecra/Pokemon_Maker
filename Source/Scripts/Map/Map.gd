extends Node2D

func init_map_objects(node: Node) -> void:
	if node is MapObject:
		node.player_enter_map()
	else:
		for child in node.get_children():
			init_map_objects(child)

func deinit_map_objects(node: Node) -> void:
	if node is MapObject:
		node.player_leave_map()
	else:
		for child in node.get_children():
			deinit_map_objects(child)

func enter(position: Vector2) -> void:
	Global.player.teleport(self, position)
	init_map_objects(self)

func enter_tile(x_tile: int, y_tile: int) -> void:
	enter(Utils.pixel_pos(Vector2(x_tile, y_tile)))

func leave() -> void:
	deinit_map_objects(self)

func _ready() -> void:
	Global.map = self
	yield(get_tree().create_timer(1), "timeout")
	enter_tile(7, 13)
