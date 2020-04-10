extends "res://Source/Scripts/Map/Character.gd"

const StatusFreeMovement = preload("res://Source/Scripts/Map/CharacterStatus/StatusFreeMovement.gd")
const MovementFree = preload("res://Source/Scripts/Map/Movements/MovementFree.gd")
const MovementTileBased = preload("res://Source/Scripts/Map/Movements/MovementTileBased.gd")
const PlayerController = preload("res://Source/Scripts/Map/CharacterController/PlayerController.gd")

func _ready():
	self.status = StatusFreeMovement.new()
	
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
