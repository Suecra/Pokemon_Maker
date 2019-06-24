extends "res://Source/Scripts/Battle/BattleAction.gd"

enum DamageClass {Physical, Special, Status}
enum Flags {Contact, Protect, Mirrorable, Kings_Rock, Sky_Battle, Damage, Ailment, Heal, Punch, Lower, Raise, OHKO, Field_Effect, Whole_Field_Effect}
enum HitRange {Opponent, All_Opponents, All, User, Partner, User_or_Partner, User_Field, Opponent_Field, Entire_Field}
enum ContestType {Cool, Beauty, Cute, Smart, Tough}

export(PackedScene) var type
export(DamageClass) var damage_class
export(int, 1, 255) var power
export(int, 1, 100) var accuracy
export(int, -7, 7) var priority
export(int) var pp
export(int, 1, 255) var z_power

export(Flags, FLAGS) var flags
export(HitRange) var hit_range
export(bool) var is_HM

export(ContestType) var contest_type
export(PackedScene) var contest_effect
export(int, "Attack", "Defense", "Support") var battle_style
export(String) var description