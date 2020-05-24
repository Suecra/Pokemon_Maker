extends Node2D

func _physics_process(delta):
	#position = -get_tree().root.canvas_transform.get_origin() / 4
	#print(get_tree().root.canvas_transform.affine_inverse().get_origin())
	transform = get_tree().root.canvas_transform.affine_inverse()
