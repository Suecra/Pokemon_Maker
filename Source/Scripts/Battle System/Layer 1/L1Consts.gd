class_name L1Consts

enum SenderType {SELF, ALLY, OPPONENT, ALLY_FIELD, OPPONENT_FIELD, ALLY_TEAM, OPPONENT_TEAM, BATTLEFIELD}
enum MessageType {VOID, BOOL, INT, FLOAT, ARRAY}

const MESSAGES = {
	"nudge": [MessageType.VOID, []]
}
