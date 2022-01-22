extends WATTest

const BattleActionDamage = preload("res://Source/Scripts/Battle System/Layer 0/BattleActionDamage.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
var battle_action_damage: BattleActionDamage
var fighter: Fighter

func test_execute() -> void:
	fighter.hp = 80
	battle_action_damage._execute()
	asserts.is_equal(68, fighter.hp)

func pre() -> void:
	fighter = Fighter.new()
	battle_action_damage = BattleActionDamage.new(fighter, 12)
