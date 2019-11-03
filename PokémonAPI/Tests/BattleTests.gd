extends WATTest

const Battle = preload("res://Source/Scripts/Battle/Battle.gd")
const Pokemon = preload("res://Source/Scripts/Battle/Pokemon.gd")
const Movepool = preload("res://Source/Scripts/Battle/Movepool.gd")
const SPECIES_PATH = "res://Source/Data/Pokemon/"
const NATURE_PATH = "res://Source/Data/Nature/"
const MOVE_PATH = "res://Source/Data/Move/"

var battle_scene = preload("res://Scenes/BattleBase.tscn")
var trainer_scene = preload("res://Scenes/Trainer/TestTrainer.tscn")

var battle: Battle
var trainer1
var trainer2

func set_up():
	battle = battle_scene.instance()
	add_child(battle)
	trainer1 = trainer_scene.instance()
	trainer2 = trainer_scene.instance()
	battle.add_ally_trainer(trainer1)
	battle.add_opponent_trainer(trainer2)

func tear_down():
	remove_child(battle)

func create_basic_pokemon(name: String, level: int, moves: Array, nature: String) -> Pokemon:
	var pokemon = Pokemon.new()
	pokemon.species = load(SPECIES_PATH + name + ".tscn")
	pokemon.nature = load(NATURE_PATH + nature + ".tscn")
	pokemon.level = level
	var movepool = Movepool.new()
	movepool.owner = pokemon
	movepool.name = "Movepool"
	pokemon.add_child(movepool)
	pokemon.calculate_stats()
	pokemon.current_hp = 9999
	for move in moves:
		movepool.add_move(load(MOVE_PATH + move + ".tscn"))
	return pokemon

func test_add_pokemon():
	var charmander := create_basic_pokemon("charmander", 5, ["tackle"], "hardy")
	var squirtle := create_basic_pokemon("squirtle", 5, ["tackle"], "hardy")
	trainer1.pokemon_party.add_child(charmander)
	trainer2.pokemon_party.add_child(squirtle)
	
	expect.is_equal(1, trainer1.pokemon_party.get_pokemon_count(), "Trainer1 has 1 Pokemon")
	expect.is_equal(1, trainer2.pokemon_party.get_pokemon_count(), "Trainer2 has 1 Pokemon")
	
	expect.is_equal(18, charmander.current_hp, "Charmander has 18 hp")
	expect.is_equal(10, charmander.attack, "Charmander has 10 attack")
	expect.is_equal(9, charmander.defense, "Charmander has 9 defense")
	expect.is_equal(11, charmander.special_attack, "Charmander has 11 special attack")
	expect.is_equal(10, charmander.special_defense, "Charmander has 10 special defense")
	expect.is_equal(11, charmander.speed, "Charmander has 11 speed")
	
	expect.is_equal(19, squirtle.current_hp, "Squirtle has 19 hp")
	expect.is_equal(9, squirtle.attack, "Squirtle has 9 attack")
	expect.is_equal(11, squirtle.defense, "Squirtle has 11 defense")
	expect.is_equal(10, squirtle.special_attack, "Squirtle has 10 special attack")
	expect.is_equal(11, squirtle.special_defense, "Squirtle has 11 special defense")
	expect.is_equal(9, squirtle.speed, "Squirtle has 9 speed")

func test_modified_pokemon():
	var zangoose := create_basic_pokemon("zangoose", 42, ["tackle"], "adamant")
	var seviper := create_basic_pokemon("seviper", 69, ["tackle"], "hardy")
	
	zangoose.attack_iv = 31
	zangoose.speed_iv = 20
	zangoose.special_attack_iv = 5
	zangoose.attack_ev = 252
	zangoose.speed_ev = 252
	zangoose.calculate_stats()
	
	seviper.hp_iv = 12
	seviper.hp_ev = 252
	seviper.defense_iv = 28
	seviper.defense_ev = 128
	seviper.special_defense_ev = 128
	seviper.calculate_stats()
	seviper.current_hp = 9999
	
	expect.is_equal(155, zangoose.attack, "Zangoose has 155 attack")
	expect.is_equal(51, zangoose.special_attack, "Zangoose has 51 special_attack")
	expect.is_equal(115, zangoose.speed, "Zangoose has 115 speed")
	
	expect.is_equal(231, seviper.current_hp, "Seviper has 231 hp")
	expect.is_equal(129, seviper.defense, "Seviper has 129 defense")
	expect.is_equal(109, seviper.special_defense, "Seviper has 109 special_defense")

func pre():
	set_up()

func end():
	tear_down()