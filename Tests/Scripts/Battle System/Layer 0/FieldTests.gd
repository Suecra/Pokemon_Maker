extends WATTest

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
const Team = preload("res://Source/Scripts/Battle System/Layer 0/Team.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
var field: Field

func test_add_team() -> void:
	var team = field.add_team()
	asserts.is_equal(1, field.teams.size())
	asserts.is_equal(team, field.teams[0])

func test_update_defeated() -> void:
	var team = field.add_team()
	field.update_defeated()
	asserts.is_false(field.defeated)
	var team2 = field.add_team()
	team.defeated = true
	field.update_defeated()
	asserts.is_false(field.defeated)
	team2.defeated = true
	field.update_defeated()
	asserts.is_true(field.defeated)

func test_is_position_blocked() -> void:
	var team = field.add_team()
	var fighter = team.add_fighter()
	field.size = 3
	fighter.position = 2
	fighter.active = true
	asserts.is_false(field.is_position_blocked(1))
	asserts.is_true(field.is_position_blocked(2))
	fighter.active = false
	asserts.is_false(field.is_position_blocked(2))
	fighter.active = true
	fighter.fainted = true
	asserts.is_false(field.is_position_blocked(2))

func test_is_position_out_of_bounds() -> void:
	field.size = 5
	asserts.is_false(field.is_position_out_of_bounds(2))
	asserts.is_true(field.is_position_out_of_bounds(5))
	asserts.is_false(field.is_position_out_of_bounds(0))
	asserts.is_true(field.is_position_out_of_bounds(18))
	asserts.is_true(field.is_position_out_of_bounds(-1))

func test_get_entity_relation() -> void:
	var team = field.add_team()
	var fighter = team.add_fighter()
	asserts.is_equal(BattleEntity.Role.SELF, field._get_entity_relation(field))
	asserts.is_equal(BattleEntity.Role.ALLY, field._get_entity_relation(field.team))
	asserts.is_equal(BattleEntity.Role.ALLY, field._get_entity_relation(fighter))
	asserts.is_equal(BattleEntity.Role.OPPONENT, field._get_entity_relation(Fighter.new()))
	asserts.is_equal(BattleEntity.Role.OPPONENT, field._get_entity_relation(Team.new()))
	asserts.is_equal(BattleEntity.Role.OPPONENT, field._get_entity_relation(Field.new()))
	asserts.is_equal(BattleEntity.Role.BATTLEFIELD, field._get_entity_relation(Battlefield.new()))

func test_get_type() -> void:
	asserts.is_equal(BattleEntity.Type.FIELD, field._get_type())

func pre() -> void:
	field = Field.new()
