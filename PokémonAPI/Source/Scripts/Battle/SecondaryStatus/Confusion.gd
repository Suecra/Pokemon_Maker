extends "res://Source/Scripts/Battle/SecondaryStatus.gd"

const Utils = preload("res://Source/Scripts/Utils.gd")
const SELF_HIT_CHANCE = 1.0 / 3.0

var counter

func _init():
	status_name = "Confusion"

func _ready():
	counter = randi() % 4 + 2
	register(pokemon, "CAN_MOVE", "can_move", -1)

func can_move(args):
	if args.can_move:
		if counter == 0:
			_heal()
		else:
			counter -= 1
			battle.register_message(pokemon.nickname + " is confused!")
			if Utils.trigger(SELF_HIT_CHANCE):
				args.can_move = false
				do_self_hit()

func do_self_hit():
	var self_hit = load("res://Source/Data/Move/ConfusionHitMove.tscn").instance()
	self_hit.user = pokemon
	self_hit.battle = battle
	self_hit.targets.append(pokemon)
	self_hit.turn = battle.current_turn
	battle.register_message(pokemon.nickname + " hit itself by it's confusion!")
	self_hit._hit()

func _heal():
	battle.register_message(pokemon.nickname + " is no longer confused!")
	._heal()