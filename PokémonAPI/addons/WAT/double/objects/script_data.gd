extends Reference

const DOUBLE: String = "double"
var _methods: Dictionary = {}
var instance: Object
const is_scene: bool = false
signal DOUBLE_EXECUTE_METHOD

enum {
	FULL
	PARTIAL
}

func _init(methods: Array, instance, strategy) -> void:
	self.instance = instance
	self.instance.set_meta(DOUBLE, self)
	for method in methods:
		_add_method(method.name)
		_methods[method.name].is_doubled = true if strategy == FULL else false

func execute(method: String, count: int = 0, a = null, b = null, c = null, d = null, e = null, f = null, g = null, h = null, i = null):
	var args: Array = [a, b, c, d, e,f, g, h, i]
	args.resize(count)
	return self.instance.callv(method, args)
	
func default(title: String, value) -> void:
	_methods[title].default(value)

func _add_method(title) -> void:
	_methods[title] = Method.new(title)
	
func stub(title: String, arguments: Dictionary, retval) -> void:
	_methods[title].stub(arguments, retval)
	
func call_count(title: String) -> int:
	return _methods[title].call_count
	
func get_retval(title: String, arguments: Dictionary):
	return _methods[title].get_retval(arguments)
	
func is_doubled(title: String) -> bool:
	return _methods[title].is_doubled
	
func add_call(title: String, args: Dictionary):
	_methods[title].add_call(args)
	
class Method extends Reference:
	var title: String
	var calls: Array = []
	var stubs: Array = []
	var call_count: int = 0
	var default_retval
	var is_doubled: bool = true
	
	func _init(title: String) -> void:
		self.title = title
	
	func default(value):
		is_doubled = true
		default_retval = value
		
	func stub(arguments: Dictionary, retval) -> void:
		is_doubled = true
		stubs.append({"arguments": arguments, "retval": retval})
		
	func get_retval(arguments: Dictionary):
		for stub in stubs:
			if _key_value_match(arguments, stub.arguments):
				return stub.retval
		return default_retval

	func add_call(arguments: Dictionary) -> void:
		self.call_count += 1
		calls.append(arguments)
		
	func _key_value_match(a: Dictionary, b: Dictionary) -> bool:
		for key in a:
			if a[key] != b[key]:
				return false
		return true