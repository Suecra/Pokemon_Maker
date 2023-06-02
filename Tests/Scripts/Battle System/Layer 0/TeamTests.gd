extends WATTest

const Team = preload("res://Source/Scripts/Battle System/Layer 0/Team.gd")
const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
var team: Team

func test_add_fighter() -> void:
	var fighter = team.add_fighter()
	asserts.is_equal(1, team.fighters.size())
	asserts.is_equal(fighter, team.fighters[0])

func test_get_entity_relation() -> void:
	var fighter = team.add_fighter()
	team.field = Field.new()
	asserts.is_equal(L1Consts.Role.OWNER, team._get_entity_relation(team))
	asserts.is_equal(L1Consts.Role.ALLY, team._get_entity_relation(team.field))
	asserts.is_equal(L1Consts.Role.ALLY, team._get_entity_relation(fighter))
	asserts.is_equal(L1Consts.Role.OPPONENT, team._get_entity_relation(Fighter.new()))
	asserts.is_equal(L1Consts.Role.OPPONENT, team._get_entity_relation(Team.new()))
	asserts.is_equal(L1Consts.Role.OPPONENT, team._get_entity_relation(Field.new()))
	asserts.is_equal(L1Consts.Role.BATTLEFIELD, team._get_entity_relation(Battlefield.new()))

func test_update_defeated() -> void:
	var fighter = team.add_fighter()
	team.update_defeated()
	asserts.is_false(team.defeated)
	var fighter2 = team.add_fighter()
	fighter.defeated = true
	team.update_defeated()
	asserts.is_false(team.defeated)
	fighter2.defeated = true
	team.update_defeated()
	asserts.is_true(team.defeated)

func test_get_type() -> void:
	asserts.is_equal(BattleEntity.Type.TEAM, team._get_type())

func pre() -> void:
	team = Team.new()
