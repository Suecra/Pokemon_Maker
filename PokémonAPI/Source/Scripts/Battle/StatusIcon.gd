extends Node2D

export(String) var status setget set_status

var last_visible_node: Node2D

func set_status(value):
	if value != status:
		status = value
		update_visiblity(false)
		match status:
			"burn": last_visible_node = $Burn
			"freeze": last_visible_node = $Freeze
			"paralysis": last_visible_node = $Paralysis
			"poison": last_visible_node = $Poison
			"sleep": last_visible_node = $Sleep
			"": last_visible_node = null
		update_visiblity(true)

func update_visiblity(visible):
	if last_visible_node != null:
		last_visible_node.visible = visible

func _ready():
	pass
