class_name L1Consts

enum SenderType {SELF, ALLY, SELF_OR_ALLY, OPPONENT, BATTLEFIELD}
enum MessageType {VOID, BOOL, NUMBER, ENTITY, ARRAY}
enum Role {SELF, ALLY, OPPONENT, BATTLEFIELD}
enum MoveFailReason {NO_TARGET, NO_EFFECT}
enum MoveCategory {PHYSICAL, SPECIAL, STATUS}
enum EffectReplaceMode {NONE, FIFO, LIFO}
enum BattleOptions {FIGHT, ITEM, SWITCH, RUN}
enum TargetType {SELF, SINGLE, SINGLE_SELF, MULTI, ALLY, ALLY_SELF, ALLY_TEAM, OPPONENT_TEAM, BATTLEFIELD}
enum TargetPosition {LEFT_ALLY, SELF, RIGHT_ALLY, LEFT_OPPONENT, CENTER_OPPONENT, RIGHT_OPPONENT}

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

static func get_target_positions(target_type: int, position: int, target_index: int, field_size: int) -> Array:
	match target_type:
		TargetType.SELF:
			return [position]
		TargetType.SINGLE, TargetType.SINGLE_SELF:
			match target_index:
				TargetPosition.LEFT_ALLY:
					if position > 1:
						return [position - 1]
				TargetPosition.SELF:
					if target_type == TargetType.SINGLE_SELF:
						return [position]
				TargetPosition.RIGHT_ALLY:
					if position < field_size - 1:
						return [position + 1]
				TargetPosition.LEFT_OPPONENT:
					if position > 0:
						return [-(position - 1)]
				TargetPosition.CENTER_OPPONENT:
					if target_type == TargetType.SINGLE_SELF:
						return [-position]
				TargetPosition.RIGHT_OPPONENT:
					if position < field_size:
						return [-(position + 1)]
			return [-position]
		TargetType.MULTI:
			var result = [-position]
			if position > 1:
				result.append(position - 1)
				result.append(-(position - 1))
			if position < field_size:
				result.append(position + 1)
				result.append(-(position + 1))
		TargetType.ALLY, TargetType.ALLY_SELF:
			match target_index:
				TargetPosition.LEFT_ALLY:
					if position > 1:
						return [position - 1]
				TargetPosition.SELF:
					if target_type == TargetType.ALLY_SELF:
						return [position]
				TargetPosition.RIGHT_ALLY:
					if position < field_size - 1:
						return [position + 1]
			if position > 1:
				return [position - 1]
			else:
				return [position + 1]
		TargetType.ALLY_TEAM:
			var result = []
			for p in range(field_size):
				result.append(position + 1)
		TargetType.OPPONENT_TEAM:
			var result = []
			for p in range(field_size):
				result.append(-(position + 1))
		TargetType.BATTLEFIELD:
			var result = []
			for p in range(field_size):
				result.append(position + 1)
			for p in range(field_size):
				result.append(-(position + 1))
	return [0]
