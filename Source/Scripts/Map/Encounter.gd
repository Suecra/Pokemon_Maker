extends Node

const WildPokemonTrainer = preload("res://Scenes/Trainer/WildPokemonTrainer.tscn")
const Pokemon = preload("res://Source/Scripts/Battle/Pokemon.gd")

export(String) var pokemon_name
export(int, 1, 100) var min_level
export(int, 1, 100) var max_level
export(int) var chance setget set_chance

var encounters

func set_chance(value: int) -> void:
	if chance != value:
		chance = value
		if encounters != null:
			encounters.update_total_chance()

func encounter_pokemon() -> void:
	var event = Global.new_event(self)
	var wild_pokemon_trainer = WildPokemonTrainer.instance()
	wild_pokemon_trainer.name = "Trainer"
	add_child(wild_pokemon_trainer)
	wild_pokemon_trainer.owner = self
	
	var pokemon = Pokemon.new(pokemon_name)
	var r = randi() % (1 + max_level - min_level)
	pokemon.level = r + min_level
	pokemon.encounter()
	wild_pokemon_trainer.pokemon_party.add_pokemon(pokemon)
	
	event.add_action(EventActionBattle.new(Global.player.trainer, wild_pokemon_trainer))
	event.start()

func _ready() -> void:
	encounters = get_parent()
