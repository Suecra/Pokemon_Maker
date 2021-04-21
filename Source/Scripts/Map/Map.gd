extends Node2D

onready var tilemaps = $Map

func init_map_objects(node: Node) -> void:
	if node.has_method("player_enter_map"):
		node.player_enter_map()
	else:
		for child in node.get_children():
			init_map_objects(child)

func deinit_map_objects(node: Node) -> void:
	if node.has_method("player_leave_map"):
		node.player_leave_map()
	else:
		for child in node.get_children():
			deinit_map_objects(child)

func enter(position: Vector2) -> void:
	Global.player.teleport(self, position)
	Global.player.connect("step_taken", self, "player_step_taken")
	init_map_objects(self)

func enter_tile(x_tile: int, y_tile: int) -> void:
	enter(Utils.pixel_pos(Vector2(x_tile, y_tile)))

func leave() -> void:
	deinit_map_objects(self)

func get_terrain_tags(position: Vector2) -> Array:
	var terrain_tags = []
	for map in tilemaps.get_children():
		var tileset = map.tile_set
		var tile_id = map.get_cell(position.x, position.y)
		if tileset.has_meta("tile_meta"):
			var tile_meta = tileset.get_meta("tile_meta")
			if tile_meta.has(tile_id):
				if tile_meta[tile_id].has("terrain_tag"):
					terrain_tags.append(tile_meta[tile_id]["terrain_tag"])
	return terrain_tags

func get_terrain_tags_player() -> Array:
	return get_terrain_tags(Utils.tile_pos(Global.player.get_position()))

func _enter_tree() -> void:
	Global.map = self
