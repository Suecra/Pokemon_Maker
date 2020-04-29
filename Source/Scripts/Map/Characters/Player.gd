extends "res://Source/Scripts/Map/Character.gd"

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const MovementFree = preload("res://Source/Scripts/Map/Movements/MovementFree.gd")
const MovementTileBased = preload("res://Source/Scripts/Map/Movements/MovementTileBased.gd")
const PlayerController = preload("res://Source/Scripts/Map/CharacterController/PlayerController.gd")

signal action

var triggered_map_object: MapObject

func _ready():
	self.status = StatusFreeMovement.new()
	
	if Global.MOVEMENT == Global.MOVEMENT_TYPE.FREE:
		movement = MovementFree.new()
	else:
		movement = MovementTileBased.new()
	movement.character = self
	movement.body = $Body
	movement.name = "Movement"
	
	controller = PlayerController.new()
	controller.character = self
	controller.name = "Controller"
	
	sprite = $Body/PlayerSprite
	sprite.direction = Vector2(0, 1)
	
	walking_speed = 64
	running_speed = 128
	
	add_child(movement)
	add_child(controller)

func _physics_process(delta):
	if status.can_move() && Input.is_action_just_pressed("select|action"):
		triggered_map_object = null
		emit_signal("action")
		if triggered_map_object != null:
			triggered_map_object._trigger()

func request_trigger(mapObject: MapObject):
	if triggered_map_object == null:
		#TODO: Check if nearest object
		triggered_map_object = mapObject
