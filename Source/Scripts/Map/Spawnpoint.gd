extends Node2D

func _physics_process(delta) -> void:
	Global.map.enter(position)
	set_physics_process(false)
