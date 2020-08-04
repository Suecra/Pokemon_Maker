extends "res://Source/Scripts/Battle/SecondaryStatus.gd"

const SELF_HIT_CHANCE = 1.0 / 3.0

var counter: int

func _init() -> void:
	status_name = "Confusion"

func _ready() -> void:
	counter = randi() % 4 + 2
	register(pokemon, "CAN_MOVE", "can_move", -1)
	battle.register_message(pokemon.nickname + " became confused!")

func can_move(args: Reference) -> void:
	if args.can_move:
		if counter == 0:
			_heal()
		else:
			counter -= 1
			battle.register_message(pokemon.nickname + " is confused!")
			if Utils.trigger(SELF_HIT_CHANCE):
				args.can_move = false
				do_self_hit()

func do_self_hit() -> void:
	var self_hit = load("res://Source/Data/Move/ConfusionHitMove.tscn").instance()
	self_hit.user = pokemon
	self_hit.battle = battle
	self_hit.targets.append(pokemon)
	self_hit.turn = battle.current_turn
	battle.register_message(pokemon.nickname + " hit itself by it's confusion!")
	self_hit._hit(pokemon)

func _heal() -> void:
	battle.register_message(pokemon.nickname + " is no longer confused!")
	._heal()
