extends WATTest

const Battle = preload("res://Source/Scripts/Battle System/Layer 0/Battle.gd")
const BattleActionDamage = preload("res://Source/Scripts/Battle System/Layer 0/BattleActionDamage.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
var battle: Battle
var battle_action_damage: BattleActionDamage
var fighter: Fighter
var field1: Field
var field2: Field
var battlefield: Battlefield

func test_start() -> void:
	battle.start()
	asserts.is_equal(Battle.BattleState.RUNNING, battle.state)
	asserts.is_equal(0, battle.actions.size())

func test_abort() -> void:
	battle.abort()
	asserts.is_equal(Battle.BattleState.ABORTED, battle.state)

func test_do_action() -> void:
	fighter.hp = 50
	battle.state = Battle.BattleState.INACTIVE
	battle.do_action(battle_action_damage)
	asserts.is_equal(50, fighter.hp)
	asserts.is_equal(0, battle.actions.size())
	battle.state = Battle.BattleState.RUNNING
	battle.do_action(battle_action_damage)
	asserts.is_equal(20, fighter.hp)
	asserts.is_equal(battle_action_damage, battle.actions[0])

func test_check_finished() -> void:
	battle.state = Battle.BattleState.RUNNING
	field1.defeated = false
	field2.defeated = false
	battle.check_finished()
	asserts.is_equal(Battle.BattleState.RUNNING, battle.state)
	asserts.is_equal(null, battle.winner)
	field1.defeated = true
	battle.check_finished()
	asserts.is_equal(Battle.BattleState.INACTIVE, battle.state)
	asserts.is_equal(field2, battle.winner)

func pre() -> void:
	battle = Battle.new()
	fighter = Fighter.new()
	battlefield = Battlefield.new()
	field1 = battlefield.add_field()
	field2 = battlefield.add_field()
	fighter.field = field1
	battle.battlefield = battlefield
	battle_action_damage = BattleActionDamage.new(fighter, 30)
