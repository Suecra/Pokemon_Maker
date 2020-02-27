extends Control

const Pokemon = preload("res://Source/Scripts/Battle/Pokemon.gd")
const Move = preload("res://Source/Scripts/Battle/Move.gd")
const PokemonParty = preload("res://Source/Scripts/Battle/PokemonParty.gd")
const PokemonList = preload("res://Source/Scripts/Collections/PokemonList.gd")
const MoveList = preload("res://Source/Scripts/Collections/MoveList.gd")

var pokemon_party
var selected_pokemon
var selected_move

func _ready():
	pokemon_party = PokemonParty.new()
	add_child(pokemon_party)

func _on_PokemonList_add():
	var pokemon = Pokemon.new()
	pokemon_party.add_pokemon(pokemon)
	_on_PokemonList_select(pokemon_party.get_pokemon_count() - 1)

func _on_PokemonList_remove(index: int):
	var pokemon = pokemon_party.get_child(index)
	pokemon_party.remove_pokemon(pokemon)
	_on_PokemonList_select(index - 1)

func _on_PokemonList_select(index: int):
	if index == -1:
		selected_pokemon = null
	else:
		selected_pokemon = pokemon_party.get_child(index)
		$PnlPlayer/Level.value = selected_pokemon.level
		
		$PnlPlayer/HPEV.value = selected_pokemon.hp_ev
		$PnlPlayer/AttackEV.value = selected_pokemon.attack_ev
		$PnlPlayer/DefenseEV.value = selected_pokemon.defense_ev
		$PnlPlayer/SAttackEV.value = selected_pokemon.special_attack_ev
		$PnlPlayer/SDefenseEV.value = selected_pokemon.special_defense_ev
		$PnlPlayer/InitEV.value = selected_pokemon.speed_ev
		
		$PnlPlayer/HPIV.value = selected_pokemon.hp_iv
		$PnlPlayer/AttackIV.value = selected_pokemon.attack_iv
		$PnlPlayer/DefenseIV.value = selected_pokemon.defense_iv
		$PnlPlayer/SAttackIV.value = selected_pokemon.special_attack_iv
		$PnlPlayer/SDefenseIV.value = selected_pokemon.special_defense_iv
		$PnlPlayer/InitIV.value = selected_pokemon.speed_iv
		
		var nature = selected_pokemon.get_nature()
		if nature == null:
			$PnlPlayer/Nature.text = ""
		else:
			$PnlPlayer/Nature.text = nature.nature_name
		
		update_moves()

func update_moves():
	var movepool = selected_pokemon.get_movepool()
	$PnlPlayer/MoveList.load_from_strings(movepool.to_string_array())

func _on_MoveList_add():
	if selected_pokemon != null:
		var move = Move.new()
		selected_pokemon.get_movepool().add_child(move)
		_on_MoveList_select(selected_pokemon.get_movepool().get_child_count() - 1)

func _on_MoveList_remove(index: int):
	if selected_pokemon != null && selected_move != null:
		selected_pokemon.get_movepool().remove_child(selected_move)
		_on_MoveList_select(index - 1)

func _on_MoveList_select(index: int):
	if index == -1:
		selected_move = null
	elif selected_pokemon != null:
		selected_move = selected_pokemon.get_movepool().get_child(index)

func _on_SpeciesEdit_item_selected(text):
	if selected_pokemon != null:
		selected_pokemon.species = load("res://" + PokemonList.POKEMON[text]["path"] + ".tscn")
		$PnlPlayer/PokemonList.set_selected_text(text)
		$PnlPlayer/PokemonList.set_selected_icon(PokemonList.get_single_icon(PokemonList.POKEMON[text]["id"]))

func _on_PokemonList_save_required(index):
	selected_pokemon.level = $PnlPlayer/Level.value
		
	selected_pokemon.hp_ev = $PnlPlayer/HPEV.value
	selected_pokemon.attack_ev = $PnlPlayer/AttackEV.value
	selected_pokemon.defense_ev = $PnlPlayer/DefenseEV.value
	selected_pokemon.special_attack_ev = $PnlPlayer/SAttackEV.value
	selected_pokemon.special_defense_ev = $PnlPlayer/SDefenseEV.value
	selected_pokemon.speed_ev = $PnlPlayer/InitEV.value
	
	selected_pokemon.hp_iv = $PnlPlayer/HPIV.value
	selected_pokemon.attack_iv = $PnlPlayer/AttackIV.value
	selected_pokemon.defense_iv = $PnlPlayer/DefenseIV.value
	selected_pokemon.special_attack_iv = $PnlPlayer/SAttackIV.value
	selected_pokemon.special_defense_iv = $PnlPlayer/SDefenseIV.value
	selected_pokemon.speed_iv = $PnlPlayer/InitIV.value

func _on_Nature_item_selected(text):
	if selected_pokemon != null:
		selected_pokemon.nature = load("res://Source/Data/Nature/" + text + ".tscn")

func _on_btnMoveAutoFill_button_down():
	if selected_pokemon != null:
		selected_pokemon.level = $PnlPlayer/Level.value
		var species = selected_pokemon.get_species()
		if species != null:
			selected_pokemon.get_movepool().fill_from_last_learnable_moves()
			$PnlPlayer/MoveList.load_from_strings(selected_pokemon.get_movepool().to_string_array())

func _on_MoveEdit_item_selected(text):
	if selected_move != null:
		selected_move.move = load("res://" + MoveList.MOVE[text]["path"] + ".tscn")
		$PnlPlayer/MoveList.set_selected_text(text)
