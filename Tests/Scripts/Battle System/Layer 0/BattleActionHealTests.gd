extends WATTest

const BattleActionHeal = preload("res://Source/Scripts/Battle System/Layer 0/BattleActionHeal.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
var battle_action_heal: BattleActionHeal
var fighter: Fighter

func test_execute() -> void:
	fighter.hp = 50
	battle_action_heal._execute()
	asserts.is_equal(73, fighter.hp)

func pre() -> void:
	fighter = Fighter.new()
	battle_action_heal = BattleActionHeal.new(fighter, 23)
