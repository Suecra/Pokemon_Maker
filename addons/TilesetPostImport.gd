extends Node

func post_import(scene):
	if scene.has_meta("tile_meta"):
		var tile_meta = scene.get_meta("tile_meta")
		for k in tile_meta.keys():
			if tile_meta[k].has("z_index"):
				scene.tile_set_z_index(k, tile_meta[k]["z_index"])
	return scene
