extends Reference

const BattleAction = preload("res://Source/Scripts/Battle System/Layer 0/BattleAction.gd")
const Battlefield = preload("res://Source/Scripts/Battle System/Layer 0/Battlefield.gd")
const Field = preload("res://Source/Scripts/Battle System/Layer 0/Field.gd")

enum BattleState {INACTIVE, RUNNING, FINISHED, ABORTED}

var state = BattleState.INACTIVE
var winner: Field
var actions = []
var battlefield: Battlefield

func start() -> void:
	state = BattleState.RUNNING
	actions.clear()

func do_action(action: BattleAction) -> void:
	if state == BattleState.RUNNING:
		actions.append(action)
		action._execute()
		check_finished()

func check_finished() -> void:
	var defeated_field_count = 0
	for field in battlefield.fields:
		if field.defeated:
			defeated_field_count += 1
		else:
			winner = field
	if defeated_field_count == battlefield.fields.size() - 1:
		state = BattleState.INACTIVE
	else:
		winner = null

func abort() -> void:
	state = BattleState.ABORTED

func _init() -> void:
	battlefield = Battlefield.new()
