extends Node2D

func _physics_process(delta):
	transform = get_tree().root.canvas_transform.affine_inverse()
