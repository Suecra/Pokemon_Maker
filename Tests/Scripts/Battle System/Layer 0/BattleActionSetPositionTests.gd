extends WATTest

const BattleActionSetPosition = preload("res://Source/Scripts/Battle System/Layer 0/BattleActionSetPosition.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
var battle_action_set_position: BattleActionSetPosition
var fighter: Fighter
var field: Field

func test_execute() -> void:
	field.size = 3
	battle_action_set_position._execute()
	asserts.is_equal(2, fighter.position)

func pre() -> void:
	fighter = Fighter.new()
	field = Field.new()
	fighter.field = field
	battle_action_set_position = BattleActionSetPosition.new(fighter, 2)
