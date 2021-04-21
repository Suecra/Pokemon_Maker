extends Node

enum ENCOUNTER_TYPE {Grass = 0, Water = 1, Cave = 2}

export(ENCOUNTER_TYPE) var type
export(bool) var enabled = true
export(float) var chance = 0.1

var total_chance

func player_enter_map() -> void:
	Global.player.connect("step_taken", self, "player_step_taken")
	update_total_chance()

func update_total_chance() -> void:
	total_chance = 0
	for encounter in get_children():
		total_chance += encounter.chance

func player_step_taken() -> void:
	if not enabled:
		return
	if not Utils.trigger(chance):
		return
	match type:
		ENCOUNTER_TYPE.Grass:
			if not Global.map.get_terrain_tags_player().has(Consts.TERRAIN_TAGS.GRASS):
				return
		ENCOUNTER_TYPE.Water:
			if not Global.map.get_terrain_tags_player().has(Consts.TERRAIN_TAGS.WATER):
				return
	encounter_pokemon()

func encounter_pokemon() -> void:
	if get_child_count() == 1:
		get_child(0).encounter_pokemon()
	else:
		var r = randi() % total_chance
		var c = 0
		for encounter in get_children():
			if c >= r:
				encounter.encounter_pokemon()
				return
			c += encounter.chance

func player_leave_map() -> void:
	Global.player.disconnect("step_taken", self, "player_step_taken")
