class_name L1Consts

enum SenderType {SELF, ALLY, SELF_OR_ALLY, OPPONENT, BATTLEFIELD}
enum MessageType {VOID, BOOL, INT, FLOAT, ARRAY}
enum Role {SELF, ALLY, OPPONENT, BATTLEFIELD}

const MESSAGES = {
	"nudge": [MessageType.VOID, []]
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