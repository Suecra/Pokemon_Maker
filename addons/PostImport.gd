extends Node

func post_import(scene):
	for node in scene.get_children():
		if node.has_meta("z_index"):
			node.z_index = node.get_meta("z_index")
		var tileset = node.tile_set
		if tileset.has_meta("tile_meta"):
			var tile_meta = tileset.get_meta("tile_meta")
			for k in tile_meta.keys():
				if tile_meta[k].has("z_index"):
					tileset.tile_set_z_index(k, tile_meta[k]["z_index"])
	return scene
