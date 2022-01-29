extends WATTest

const BattleActionSetActive = preload("res://Source/Scripts/Battle System/Layer 0/BattleActionSetActive.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
var battle_action_set_active: BattleActionSetActive
var fighter: Fighter

func test_execute() -> void:
	fighter.active = false
	battle_action_set_active._execute()
	asserts.is_true(fighter.active)

func pre() -> void:
	fighter = Fighter.new()
	fighter.field = Field.new()
	battle_action_set_active = BattleActionSetActive.new(fighter, true)
