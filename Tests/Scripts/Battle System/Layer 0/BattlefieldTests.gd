extends WATTest

const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
var battlefield: Battlefield

func test_get_type() -> void:
	asserts.is_equal(BattleEntity.Type.BATTLEFIELD, battlefield._get_type())

func test_add_field() -> void:
	var field = battlefield.add_field()
	asserts.is_equal(1, battlefield.fields.size())
	asserts.is_true(field.is_class("Field"), "Field returned") 

func test_get_entity_relation() -> void:
	asserts.is_equal(BattleEntity.Role.BATTLEFIELD, battlefield._get_entity_relation(null))

func pre() -> void:
	battlefield = Battlefield.new()
