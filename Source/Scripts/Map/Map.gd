extends Node2D

var player: Node

func init_map_objects(node: Node) -> void:
	if node is MapObject:
		node.player_enter_map(self)
	else:
		for child in node.get_children():
			init_map_objects(child)

func deinit_map_objects(node: Node) -> void:
	if node is MapObject:
		node.player_leave_map(self)
	else:
		for child in node.get_children():
			deinit_map_objects(child)

func enter(player: Node, position: Vector2) -> void:
	self.player = player
	add_child(player)
	player.teleport(position)
	init_map_objects(self)

func enter_tile(player: Node, x_tile: int, y_tile: int) -> void:
	enter(player, Utils.pixel_pos(Vector2(x_tile, y_tile)))

func leave() -> void:
	deinit_map_objects(self)

func get_message_box() -> Node:
	if not has_node("MessageBox"):
		var message_box = Global.create_message_box()
		message_box.name = "MessageBox"
		message_box.auto_hide = true
		message_box.auto_skip = false
		add_child(message_box)
		message_box.owner = self
		return message_box
	return $MessageBox

func get_event(caller: MapObject) -> Node:
	if not has_node("Event"):
		var event = Event.new()
		event.map = self
		event.caller = caller
		event.name = "Event"
		add_child(event)
		event.owner = self
	$Event.clear()
	return $Event

func _ready() -> void:
	yield(get_tree().create_timer(1), "timeout")
	enter_tile($Player, 7, 13)
