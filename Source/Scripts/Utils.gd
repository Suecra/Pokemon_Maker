extends Object

static func trigger(chance: float):
	return rand_range(0, 1) < chance

static func add_node_if_not_exists(parent: Node, owner: Node, name: String):
	return add_typed_node_if_not_exists(Node, parent, owner, name)

static func add_typed_node_if_not_exists(type, parent: Node, owner: Node, name: String):
	if parent.has_node(name):
		return parent.get_node(name)
	else:
		var n = type.new()
		n.name = name
		parent.add_child(n)
		n.owner = owner
		return n

static func unpack(parent: Node, scene: PackedScene, name: String):
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

static func save_node_and_children(node: Node, path: String):
	set_node_owner(node, node)
	var scene = PackedScene.new()
	scene.pack(node)
	ResourceSaver.save(path, scene)

static func set_node_owner(node: Node, owner: Node):
	node.owner = owner
	#print(node.name + " | " + owner.name)
	for child in node.get_children():
		set_node_owner(child, owner)

static func tile_pos(pixel_pos: Vector2):
	return pixel_pos / Global.TILE_SIZE

static func pixel_pos(tile_pos: Vector2):
	return tile_pos * Global.TILE_SIZE
