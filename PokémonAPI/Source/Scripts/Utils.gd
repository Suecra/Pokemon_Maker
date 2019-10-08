extends Object

static func trigger(chance: float):
	return rand_range(0, 1) < chance

static func add_node_if_not_exists(parent: Node, owner: Node, name: String):
	if parent.has_node(name):
		return parent.get_node(name)
	else:
		var n = Node.new()
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