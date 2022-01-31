extends WATTest

func test_is_sender_type() -> void:
	asserts.is_true(L1Consts.is_sender_type(L1Consts.SenderType.SELF, L1Consts.Role.SELF))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.SELF, L1Consts.Role.ALLY))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.SELF, L1Consts.Role.OPPONENT))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.SELF, L1Consts.Role.BATTLEFIELD))
	
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.ALLY, L1Consts.Role.SELF))
	asserts.is_true(L1Consts.is_sender_type(L1Consts.SenderType.ALLY, L1Consts.Role.ALLY))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.ALLY, L1Consts.Role.OPPONENT))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.ALLY, L1Consts.Role.BATTLEFIELD))
	
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.OPPONENT, L1Consts.Role.SELF))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.OPPONENT, L1Consts.Role.ALLY))
	asserts.is_true(L1Consts.is_sender_type(L1Consts.SenderType.OPPONENT, L1Consts.Role.OPPONENT))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.OPPONENT, L1Consts.Role.BATTLEFIELD))
	
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.BATTLEFIELD, L1Consts.Role.SELF))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.BATTLEFIELD, L1Consts.Role.ALLY))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.BATTLEFIELD, L1Consts.Role.OPPONENT))
	asserts.is_true(L1Consts.is_sender_type(L1Consts.SenderType.BATTLEFIELD, L1Consts.Role.BATTLEFIELD))
	
	asserts.is_true(L1Consts.is_sender_type(L1Consts.SenderType.SELF_OR_ALLY, L1Consts.Role.SELF))
	asserts.is_true(L1Consts.is_sender_type(L1Consts.SenderType.SELF_OR_ALLY, L1Consts.Role.ALLY))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.SELF_OR_ALLY, L1Consts.Role.OPPONENT))
	asserts.is_false(L1Consts.is_sender_type(L1Consts.SenderType.SELF_OR_ALLY, L1Consts.Role.BATTLEFIELD))
