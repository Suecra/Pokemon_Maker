extends Node

func post_import(scene):
	for node in scene.get_children():
		if node.has_meta("drawOnTop"):
			if node.get_meta("drawOnTop"):
				node.z_index = 2
	return scene
