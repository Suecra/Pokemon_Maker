extends Reference

const Effect = preload("res://Source/Scripts/Battle System/Layer 1/Effect.gd")
const BattleEntity = preload("res://Source/Scripts/Battle System/Layer 0/BattleEntity.gd")
const BASE_PATH = "res://Source/Scripts/Battle System/Layer 1/Effects/"

func create_effect(name: String, owner: BattleEntity) -> Effect:
	 return load(BASE_PATH + name + ".gd").new(owner)
