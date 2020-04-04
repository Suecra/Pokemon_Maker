extends Node2D

export(String) var status setget set_status

var last_visible_node: Node2D

func set_status(value):
	if value != status:
		status = value
		update_visiblity(false)
		match status:
			"Burn": last_visible_node = $Burn
			"Freeze": last_visible_node = $Freeze
			"Paralysis": last_visible_node = $Paralysis
			"Poison", "Bad Poison": last_visible_node = $Poison
			"Sleep": last_visible_node = $Sleep
			"": last_visible_node = null
		update_visiblity(true)

func update_visiblity(visible):
	if last_visible_node != null:
		last_visible_node.visible = visible