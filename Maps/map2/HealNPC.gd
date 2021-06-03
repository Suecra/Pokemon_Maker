extends NPC

func _trigger() -> void:
	._trigger()
	Global.player.trainer.pokemon_party.full_heal_all()
