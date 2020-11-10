extends Node

var player: Node setget ,get_player
var message_box: Node setget ,get_message_box
var event: Node
var map: Node

func new_event(caller: Node) -> Node:
	if event == null:
		event = Event.new()
		event.name = "Event"
		add_child(event)
		event.owner = self
	event.clear()
	event.caller = caller
	return event

func get_player() -> Node:
	if player == null:
		player = create_player()
		player.name = "Player"
		add_child(player)
		player.owner = self
	return player

func create_player() -> Node:
	return load(Consts.PLAYER_SCENE).instance()

func get_message_box() -> Node:
	if message_box == null:
		message_box = create_message_box()
		message_box.name = "MessageBox"
		message_box.auto_hide = true
		message_box.auto_skip = false
		add_child(message_box)
		message_box.owner = self
	return message_box

func create_message_box() -> Node:
	return load(Consts.MESSAGEBOX_SCENE).instance()

static func create_pokemon(name: String) -> Pokemon:
	var pokemon = Pokemon.new()
	pokemon.load_from_file(Consts.POKEMON_PATH + name + ".json")
	return pokemon
