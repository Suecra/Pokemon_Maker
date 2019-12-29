extends "res://Source/Data/StatusMove.gd"

# DEPRECATED: Use EffectBoost instead

enum Stat {ATTACK, DEFENSE, SPECIAL_ATTACK, SPECIAL_DEFENSE, SPEED}

export(int, -6, 6) var attack_boost = 0
export(int, -6, 6) var defense_boost = 0
export(int, -6, 6) var special_attack_boost = 0
export(int, -6, 6) var special_defense_boost = 0
export(int, -6, 6) var speed_boost = 0
export(int, -6, 6) var accuracy_boost = 0
export(int, -6, 6) var evasion_boost = 0