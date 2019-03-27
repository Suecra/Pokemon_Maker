extends Node

export(int) var regional_dex_nr
export(int) var national_dex_nr

export(int, 1, 255) var hp
export(int, 1, 255) var attack
export(int, 1, 255) var defense
export(int, 1, 255) var special_attack
export(int, 1, 255) var special_defense
export(int, 1, 255) var speed

export(int) var catch_rate
export(int) var happyness
export(PackedScene) var gender_chance

export(int) var egg_cycle
export(int) var base_ep
export(PackedScene) var growth_rate
export(String) var kategory = ""
export(float) var size
export(float) var weight
export(PackedScene) var color
export(PackedScene) var shape

export(String, MULTILINE) var dex_entry