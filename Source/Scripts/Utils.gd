class_name Utils

static func trigger(chance: float) -> bool:
	return rand_range(0, 1) < chance

static func add_node_if_not_exists(parent: Node, owner: Node, name: String) -> Node:
	return add_typed_node_if_not_exists(Node, parent, owner, name)

static func add_typed_node_if_not_exists(type, parent: Node, owner: Node, name: String) -> Node:
	if parent.has_node(name):
		return parent.get_node(name)
	else:
		var node = type.new()
		node.name = name
		parent.add_child(node)
		node.owner = owner
		return node

static func unpack(parent: Node, scene: PackedScene, name: String) -> Node:
	if scene != null:
		if parent.has_node(name):
			return parent.get_node(name)
		else:
			var node = scene.instance()
			node.name = name
			parent.add_child(node)
			node.owner = parent
			return node
	return null

static func save_node_and_children(node: Node, path: String) -> void:
	set_node_owner(node, node)
	var scene = PackedScene.new()
	scene.pack(node)
	ResourceSaver.save(path, scene)

static func set_node_owner(node: Node, owner: Node) -> void:
	node.owner = owner
	for child in node.get_children():
		set_node_owner(child, owner)

static func tile_pos(pixel_pos: Vector2) -> Vector2:
	return pixel_pos / Consts.TILE_SIZE

static func pixel_pos(tile_pos: Vector2) -> Vector2:
	return tile_pos * Consts.TILE_SIZE

static func hits_target(hit_range: int) -> bool:
	match hit_range:
		0: return true
		1: return true
		2: return true
		3: return false
		4: return true
		5: return false
		6: return false
		7: return true
		8: return true
	return false

static func hits_user(hit_range: int) -> bool:
	match hit_range:
		0: return false
		1: return false
		2: return true
		3: return true
		4: return false
		5: return false
		6: return true
		7: return false
		8: return true
	return false
