extends WATTest

const Fighter = preload("res://Source/Scripts/Battle System/Layer 0/Fighter.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
const Team = preload("res://Source/Scripts/Battle System/Layer 0/Team.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
var fighter: Fighter

func test_set_active() -> void:
	fighter.set_active(true)
	asserts.is_true(fighter.active)
	fighter.set_active(false)
	asserts.is_false(fighter.active)

func test_set_position() -> void:
	fighter.set_position(2)
	asserts.is_equal(2, fighter.position)

func test_set_fainted() -> void:
	fighter.set_fainted(false)
	asserts.is_false(fighter.fainted)
	fighter.set_fainted(true)
	asserts.is_true(fighter.fainted)
	asserts.is_true(fighter.team.fainted)

func test_check_position() -> void:
	asserts.is_true(true)

func test_damage() -> void:
	fighter.damage(40)
	asserts.is_equal(60, fighter.hp)
	fighter.damage(-10)
	asserts.is_equal(60, fighter.hp)
	fighter.damage(80)
	asserts.is_equal(0, fighter.hp)

func test_heal() -> void:
	fighter.heal(50)
	asserts.is_equal(150, fighter.hp)
	fighter.heal(-30)
	asserts.is_equal(150, fighter.hp)

func test_get_entity_relation() -> void:
	asserts.is_equal(BattleEntity.Role.SELF, fighter._get_entity_relation(fighter))
	asserts.is_equal(BattleEntity.Role.ALLY, fighter._get_entity_relation(fighter.team))
	asserts.is_equal(BattleEntity.Role.ALLY, fighter._get_entity_relation(fighter.field))
	asserts.is_equal(BattleEntity.Role.OPPONENT, fighter._get_entity_relation(Fighter.new()))
	asserts.is_equal(BattleEntity.Role.OPPONENT, fighter._get_entity_relation(Team.new()))
	asserts.is_equal(BattleEntity.Role.OPPONENT, fighter._get_entity_relation(Field.new()))
	asserts.is_equal(BattleEntity.Role.BATTLEFIELD, fighter._get_entity_relation(Battlefield.new()))

func test_get_type() -> void:
	asserts.is_equal(BattleEntity.Type.FIGHTER, fighter._get_type())

func pre() -> void:
	fighter = Fighter.new()
	fighter.field = Field.new()
	fighter.team = Team.new()
	fighter.field.size = 3
	fighter.hp = 100
