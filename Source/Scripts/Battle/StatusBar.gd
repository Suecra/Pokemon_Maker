extends CanvasLayer

export(PackedScene) var style

var pokemon

func initialize(pokemon: Node) -> void:
	self.pokemon = pokemon
	update()

func update_hp() -> void:
	$Style.max_hp = pokemon.hp
	$Style.hp = pokemon.current_hp

func update_gender() -> void:
	$Style.gender = pokemon.gender

func update_level() -> void:
	$Style.level = pokemon.level

func update_pokemon_name() -> void:
	$Style.pokemon_name = pokemon.nickname

func update_status() -> void:
	var status = pokemon.primary_status
	if status == null:
		$Style.status = ""
	else:
		$Style.status = status.status_name

func update() -> void:
	update_hp()
	update_gender()
	update_level()
	update_pokemon_name()
	update_status()

func animate_damage(damage: int) -> void:
	yield($Style.play_damage_animation(damage), "completed")

func show() -> void:
	$Style.visible = true

func hide() -> void:
	$Style.visible = false

func get_style() -> Node:
	return Utils.unpack(self, style, "Style")
