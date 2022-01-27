extends "res://Source/Scripts/Battle System/Layer 1/EffectFactory.gd"

func create_effect(name: String, owner: BattleEntity):
	 return Effect.new(owner)
