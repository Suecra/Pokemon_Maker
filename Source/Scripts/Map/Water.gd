extends Node2D

func _physics_process(delta: float) -> void:
	transform = get_tree().root.canvas_transform.affine_inverse()
