extends Node

const TARGET_MIDDLE = 0
const TARGET_LEFT = 1
const TARGET_RIGHT = 2
const TARGET_MIDDLE_OPPONENT = 3
const TARGET_LEFT_OPPONENT = 4
const TARGET_RIGHT_OPPONENT = 5

const MAX_POKEMON_COUNT_ON_FIELD = 3

var weather
var field_effect
var battle

func get_pokemon_at_position(position: int, attacker_field):
	var opponent_field
	if attacker_field == battle.ally_field:
		opponent_field = battle.opponent_field
	else:
		opponent_field = battle.ally_field
	
	if position < MAX_POKEMON_COUNT_ON_FIELD:
		return attacker_field.get_pokemon_at_position(position)
	return opponent_field.get_pokemon_at_position(position - MAX_POKEMON_COUNT_ON_FIELD)

func get_status_bar(attacker_field):
	if attacker_field == battle.ally_field:
		return battle.get_node("PlayerStatusBar")
	if attacker_field == battle.opponent_field:
		return battle.get_node("EnemyStatusBar")

func _enter_tree():
	battle = get_parent()
