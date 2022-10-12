extends Reference

const BattleL0 = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const BattleL1 = preload("res://Source/Scripts/Battle System/Layer 1/Battle.gd")
const Trainer = preload("res://Source/Scripts/Battle System/Layer 2/Trainer.gd")
const Pokemon = preload("res://Source/Scripts/Battle System/Layer 2/Pokemon.gd")

var battle_l1: BattleL1
var trainers: Array
var requested_trainers: Array

func start() -> void:
	battle_l1.start()
	init_battle()

func turn() -> void:
	if requested_trainers.size() == 0:
		battle_l1.nudge_effects()
		if battle_l1.battle_l0.state == BattleL0.BattleState.RUNNING:
			battle_l1.add_effect(battle_l1.battle_l0.battlefield, "TurnActions/BeginOfTurn")
			battle_l1.add_effect(battle_l1.battle_l0.battlefield, "TurnActions/EndOfTurn")
			requested_trainers = []
			for trainer in trainers:
				requested_trainers.append(trainer)
				trainer.request_action()

func move(trainer: Trainer, pokemon: Pokemon, move_name: String, target_positions: Array) -> void:
	var effect = battle_l1.add_effect(pokemon.fighter, "TurnActions/Switch")
	effect.move_name = move_name
	effect.target_positions = target_positions
	do_action(trainer)

func switch(trainer: Trainer, from: Pokemon, to: Pokemon) -> void:
	var effect = battle_l1.add_effect(from.fighter, "TurnActions/Switch")
	effect.fighter = to
	do_action(trainer)

func item(trainer: Trainer, pokemon: Pokemon, item_name: String) -> void:
	var effect = battle_l1.add_effect(pokemon.fighter, "TurnActions/UseItem")
	effect.item_name = item_name
	do_action(trainer)

func run(trainer: Trainer) -> void:
	battle_l1.add_effect(trainer.get_field(), "TurnActions/Run")
	do_action(trainer)

func resign(trainer: Trainer) -> void:
	battle_l1.add_effect(trainer.get_field(), "TurnActions/Resign")
	do_action(trainer)

func do_action(trainer: Trainer) -> void:
	requested_trainers.erase(trainer)
	turn()

func init_battle() -> void:
	battle_l1.add_effect(battle_l1.battle_l0.battlefield, "TurnPriorityQueue")
	for trainer in trainers:
		trainer.init_battle()

func _init() -> void:
	battle_l1 = BattleL1.new()
