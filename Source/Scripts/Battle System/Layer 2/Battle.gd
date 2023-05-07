extends Reference

const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const BattleL1 = preload("res://Source/Scripts/Battle System/Layer 1/Battle.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 2/Field.gd")
const Trainer = preload("res://Source/Scripts/Battle System/Layer 2/Trainer.gd")
const Team = preload("res://Source/Scripts/Battle System/Layer 2/Team.gd")
const Pokemon = preload("res://Source/Scripts/Battle System/Layer 2/Pokemon.gd")
const Logger = preload("res://Source/Scripts/Battle System/Layer 2/Logger.gd")

var battle_l1: BattleL1
var fields: Array
var requested_pokemon: Array
var logger: Logger

func add_field() -> Field:
	var field = Field.new()
	field.battle = self
	fields.append(field)
	return field

func start() -> void:
	battle_l1.start()
	init_battle()
	turn()

func turn() -> void:
	if requested_pokemon.size() == 0:
		battle_l1.nudge_effects()
		if battle_l1.battle_l0.state == BattleL0.BattleState.RUNNING:
			battle_l1.add_effect(battle_l1.battle_l0.battlefield, "TurnActions/BeginOfTurn")
			battle_l1.add_effect(battle_l1.battle_l0.battlefield, "TurnActions/EndOfTurn")
			requested_pokemon = []
			for field in fields:
				for trainer in field.trainers:
					requested_pokemon.append_array(trainer.team.pokemon)
			for field in fields:
				field.request_action()

func get_possible_moves(pokemon: Pokemon) -> Array:
	var moves = battle_l1.effect_manager.send("get_move", [], pokemon.fighter, null)
	return moves.value

func get_move_target_type(pokemon: Pokemon, move: Reference) -> int:
	var target_type = battle_l1.effect_manager.send("get_target_type", [move.index], pokemon.fighter, null)
	return target_type.value

func move(trainer: Trainer, pokemon: Pokemon, move_name: String, target_index: int) -> void:
	var effect = battle_l1.add_effect(pokemon.fighter, "TurnActions/Move")
	effect.move_name = move_name
	effect.target_index = target_index
	do_action(trainer, [pokemon])

func switch(trainer: Trainer, from: Pokemon, to: Pokemon) -> void:
	var effect = battle_l1.add_effect(from.fighter, "TurnActions/Switch")
	effect.fighter = to
	do_action(trainer, [from])

func item(trainer: Trainer, pokemon: Pokemon, item_name: String) -> void:
	var effect = battle_l1.add_effect(pokemon.fighter, "TurnActions/UseItem")
	effect.item_name = item_name
	do_action(trainer, [pokemon])

func run(trainer: Trainer) -> void:
	battle_l1.add_effect(trainer.get_field(), "TurnActions/Run")
	do_action(trainer, trainer.team.pokemon)

func resign(trainer: Trainer) -> void:
	battle_l1.add_effect(trainer.get_field(), "TurnActions/Resign")
	do_action(trainer, trainer.team.pokemon)

func do_action(trainer: Trainer, pokemon: Array) -> void:
	for p in pokemon:
		requested_pokemon.erase(p)
	turn()

func init_battle() -> void:
	battle_l1.add_effect(battle_l1.battle_l0.battlefield, "TurnPriorityQueue")
	for field in fields:
		field.init_battle()
	if logger != null:
		logger.init_battle()
