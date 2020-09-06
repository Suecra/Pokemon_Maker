extends "res://Source/Scripts/Map/Character.gd"

const PlayerController = preload("res://Source/Scripts/Map/CharacterController/PlayerController.gd")

signal action

onready var trainer = $Trainer
var triggered_map_object: MapObject

func _ready() -> void:
	controller = PlayerController.new()
	controller.character = self
	controller.name = "Controller"
	add_child(controller)

func action_pressed() -> void:
	triggered_map_object = null
	emit_signal("action")
	if triggered_map_object != null:
		triggered_map_object._trigger()

func request_trigger(mapObject: MapObject) -> void:
	if triggered_map_object == null:
		#TODO: Check if nearest object
		triggered_map_object = mapObject
