extends WATTest

const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")
const Team = preload("res://Source/Scripts/Battle System/Layer 0/Team.gd")
var field: Field
var team: Team

func test_add_team() -> void:
	var team = field.add_team()
	asserts.is_equal(1, field.teams.size())
	asserts.is_equal(team, field.teams[0])

func test_update_defeated() -> void:
	pass

func test_is_position_blocked() -> void:
	pass

func test_is_position_out_of_bounds() -> void:
	pass

func test_get_entity_relation() -> void:
	pass

func test_get_type() -> void:
	pass

func pre() -> void:
	field = Field.new()
