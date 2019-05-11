extends Node

enum Pocket {Objects, Medicine, Balls, TMs, Berries, Letters, Battle_Items, Key_Items}

export(Pocket) var pocket
export(String) var category
export(int) var price
export(int) var sell_price

export(int) var stack_size
export(bool) var holdable
export(int) var fling_power
export(String) var description
