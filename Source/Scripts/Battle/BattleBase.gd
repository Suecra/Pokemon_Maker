extends Node2D

export(Vector2) var pokemon_position

func calculate_pokemon_position(height):
	var pos = pokemon_position
	pos.y -= int(height / 2)
	return pos