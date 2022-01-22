extends WATTest

const BattleActionSetFainted = preload("res://Source/Scripts/Battle System/Layer 0/BattleActionSetFainted.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
var battle_action_set_fainted: BattleActionSetFainted
var fighter: Fighter

func test_execute() -> void:
	fighter.fainted = false
	battle_action_set_fainted._execute()
	asserts.is_true(fighter.fainted)

func pre() -> void:
	fighter = Fighter.new()
	battle_action_set_fainted = BattleActionSetFainted.new(fighter, true)
