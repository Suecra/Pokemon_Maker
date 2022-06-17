class_name L1Consts

enum SenderType {SELF, ALLY, SELF_OR_ALLY, OPPONENT, BATTLEFIELD}
enum MessageType {VOID, BOOL, NUMBER, ENTITY, ARRAY}
enum Role {SELF, ALLY, OPPONENT, BATTLEFIELD}

const MESSAGES = {
	"nudge": MessageType.VOID,
	"get_turn_actions": MessageType.ARRAY,
	"get_priority": MessageType.NUMBER,
	"get_reference_speed": MessageType.NUMBER,
	"get_speed": MessageType.NUMBER,
	"get_max_speed": MessageType.NUMBER,
	"get_opponent_max_speed": MessageType.NUMBER,
	"execute": MessageType.VOID,
	"try_escape": MessageType.VOID,
	"escape": MessageType.VOID,
	"switch": MessageType.VOID,
	"use_item": MessageType.VOID,
	"execute_move": MessageType.VOID,
	"get_move_priority": MessageType.NUMBER,
	"get_display_pp": MessageType.NUMBER,
	#"get_display_name"
	"get_display_type": MessageType.NUMBER,
	"get_display_category": MessageType.NUMBER,
	"get_possible_targets": MessageType.ARRAY,
	"do_move": MessageType.VOID,
	"begin_of_turn": MessageType.VOID,
	"end_of_turn": MessageType.VOID,
	"get_lasting_turns": MessageType.NUMBER,
}

static func is_sender_type(type: int, role: int) -> bool:
	match role:
		Role.SELF:
			return type == SenderType.SELF || type == SenderType.SELF_OR_ALLY
		Role.ALLY:
			return type == SenderType.ALLY || type == SenderType.SELF_OR_ALLY
		Role.OPPONENT:
			return type == SenderType.OPPONENT
		Role.BATTLEFIELD:
			return type == SenderType.BATTLEFIELD
	return false
