extends WATTest

const Battle = preload("res://Source/Scripts/Battle System/Layer 2/Battle.gd")

var battle: Battle

func test_sample_battle() -> void:
	battle.start()

func pre() -> void:
	battle = BattleBuilder.build_sample_battle(self)
