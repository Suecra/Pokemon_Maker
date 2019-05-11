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
