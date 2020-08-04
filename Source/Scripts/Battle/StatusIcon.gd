extends Node2D

export(String) var status setget set_status

var last_visible_node: Node2D

onready var burn := $Burn
onready var freeze := $Freeze
onready var paralysis := $Paralysis
onready var poison := $Poison
onready var sleep := $Sleep

func set_status(value: String) -> void:
	if value != status:
		status = value
		update_visiblity(false)
		match status:
			"Burn": last_visible_node = burn
			"Freeze": last_visible_node = freeze
			"Paralysis": last_visible_node = paralysis
			"Poison", "Bad Poison": last_visible_node = poison
			"Sleep": last_visible_node = sleep
			"": last_visible_node = null
		update_visiblity(true)

func update_visiblity(visible: bool) -> void:
	if last_visible_node != null:
		last_visible_node.visible = visible
