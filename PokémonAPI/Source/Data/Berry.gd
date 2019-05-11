extends "Item.gd"

enum Firmness {Very_Soft, Soft, Hard, Very_Hard, Super_Hard}

export(float) var size
export(int) var smoothness
export(int) var soil_dryness
export(Firmness) var firmness
export(int) var grow_time
export(int) var max_harvest

export(int) var flavor_spicy
export(int) var flavor_dry
export(int) var flavor_sweet
export(int) var flavor_bitter
export(int) var flavor_sour

export(PackedScene) var natural_gift_type
export(int) var natural_gift_power